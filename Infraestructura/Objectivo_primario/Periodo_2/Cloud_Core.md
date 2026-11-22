# Arquitectura Cloud: Servidor Core API (Periodo 2)

Este documento define la infraestructura en la nube requerida para alojar el Core Fiscal bajo un modelo SaaS Multi-Tenant. 

Para capitalizar el conocimiento previo del equipo en tecnologías de Microsoft (Windows, SQL Server), la arquitectura se basará en **Microsoft Azure**.

---

## 1. Contenedorización del Core (Docker)

El Core API ya no residirá en una Máquina Virtual monolítica (Hyper-V), sino que será empaquetado en una imagen Docker. 

* **Servicio Cloud:** **Azure Container Apps (ACA)** o **Azure Kubernetes Service (AKS)**.
* **Ventajas:** 
  * **Auto-escalado:** Si es quincena o día sin IVA y miles de clientes envían facturas al mismo tiempo, Azure levantará automáticamente réplicas del contenedor para manejar la carga.
  * **Zero Downtime:** Permite actualizar la versión del Core API sin apagar el servicio para los clientes.

---

## 2. Puerta de Enlace y Balanceo (API Gateway)

Dado que cientos de clientes (con sus respectivos middlewares) intentarán golpear nuestro Core API a través de internet público, necesitamos una barrera de seguridad sólida antes de que la petición llegue al contenedor.

* **Servicio:** **Azure API Management** o **Azure Application Gateway**.
* **Funciones:**
  * **Limitación de Tasa (Rate Limiting):** Evita que un cliente envíe 10,000 facturas por segundo y sature el servicio para los demás.
  * **Terminación SSL:** Maneja el cifrado HTTPS global antes de enviar el tráfico a los contenedores internos.
  * **Enrutamiento Inteligente:** Valida el JWT (JSON Web Token) del cliente para asegurar que el `tenant_id` que viene en el token coincida con la empresa a la que intenta facturar.

---

## 3. Topología de Red Segura (VNet)

El entorno Cloud no será público en su totalidad.

* **Capa Pública (Frontend):** Solo el API Gateway tendrá una dirección IP pública.
* **Capa Privada (Backend):** Los contenedores del Core API estarán dentro de una Subred Privada (VNet) sin salida directa a internet de entrada. Solo el API Gateway puede hablarles.
* **Conexión a DIAN:** El Core API tendrá salida a internet mediante un **Azure NAT Gateway** (IP estática de salida) para que los servicios web de la DIAN puedan poner esa IP en su lista blanca si fuera necesario en el futuro.
