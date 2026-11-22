# Especificaciones Técnicas de Infraestructura del CORE API (Periodo 1)

[cite_start]Este documento define los requerimientos de hardware, sistema operativo, runtime, red y seguridad para el despliegue del componente **Core API Fiscal** en la infraestructura interna de la compañía durante el Periodo 1 (Fase de Pilotaje)[cite: 6].

---

## 1. Entorno de Alojamiento y Servidor Físico (Host)

Para el desarrollo, pruebas y posterior paso a producción, se contará con un **nuevo servidor físico dedicado de alto rendimiento**, separado de la infraestructura actual documentada en la carpeta `Ramirez`.

* **Hardware del Servidor (Host):** Servidor HP.
* **Procesamiento:** 2x Procesadores Intel® Xeon® CPU E5-2697 v2 @ 2.70GHz.
* **Memoria RAM:** 256 GB.
* **Almacenamiento:** Arreglo de 25 discos duros (Backplane).
* **Sistema Operativo Base (Host):** Windows Server 2022.

## 2. Arquitectura de Virtualización (Hyper-V) e Integración

Sobre este servidor físico (Host) se configurará un entorno virtualizado aislado (Hyper-V) para la fase de Desarrollo y Pruebas. Se aprovisionarán dos máquinas virtuales principales:

### Máquina Virtual 1 (VM1) - Datos y Extracción
* **Propósito:** Alojamiento de la Base de Datos ICG Manager (réplica/clon para pruebas), el servicio de Middleware, y la Base de Datos de Trazabilidad.
* **Ciclo de Vida:** Operará de manera aislada durante la fase de desarrollo y pruebas. Una vez aprobado el desarrollo (Go-Live), esta virtualización (específicamente la BD de ICG de pruebas) será eliminada o reconfigurada, y el sistema pasará a conectarse a los servidores reales (Base de datos actual de producción), ya sea de forma local o a través de VPN si cambian de ubicación.

### Máquina Virtual 2 (VM2) - Core API Fiscal
* **Propósito:** Alojamiento exclusivo del motor `Core API Fiscal` que procesa los documentos electrónicos, genera el XML y se comunica con la DIAN.
* **Sistema Operativo (Guest):** Windows Server 2022.
* **Asignación de Recursos (Sizing):** 
  * **Procesador (vCPU):** Por definir según pruebas de carga (se extraerán del pool de los Xeon E5).
  * **Memoria RAM:** Por definir (Dinámica/Estática según requerimiento del stack).
  * **Almacenamiento:** VHDX aprovisionado sobre el arreglo de 25 discos.


---

## 3. Stack Tecnológico y Servidor de Aplicaciones (Runtime)

El Core API se diseñará bajo una arquitectura ligera de microservicios o API REST estructurada, utilizando tecnologías optimizadas para entornos Windows Server corporativos:

* **Tecnología del Backend:** NO_DEFINIDO
* **Servidor Web / Proxy Inverso Interno:** **Internet Information Services (IIS 10)**
* **Motor XML Interno:** Librerías nativas de procesamiento XML compatibles con firmas digitales de tipo *XAdES-BES* y algoritmos de hash criptográficos SHA-384.

---

## 4. Arquitectura de Red, Puertos y Conectividad

[cite_start]El Core API operará en una zona estrictamente protegida, actuando como un puente seguro entre la base de datos interna y la red externa de la DIAN[cite: 290].

### A. Puertos de Escucha Internos (Entrada)
* **Puerto `8080` / `443` (HTTP/HTTPS Interno):** Habilitado única y exclusivamente para recibir las tramas de datos JSON crudos provenientes del Middleware de extracción.
* [cite_start]**Restricción de Red:** Este puerto estará completamente **cerrado para el internet público** en el router perimetral[cite: 292]. [cite_start]Solo responderá a peticiones HTTP locales que viajen por el adaptador virtual de red interna de Hyper-V o desde IPs del rango CGNAT de Tailscale (`100.64.0.0/10`) asociadas a administradores autorizados[cite: 27, 191].

### B. Canales de Salida (Conexiones Externas)
* **Puerto `443` (HTTPS - Web de Salida):** Abierto hacia internet únicamente para apuntar a la URL del WebService SOAP de habilitación de la DIAN: `https://vpfe-hab.dian.gov.co/WcfDianCustomerServices.svc`.
* **Puerto `993` (IMAP Seguro):** Habilitado para conectarse al servidor de correo corporativo externo (ej. Microsoft 365 / Google Workspace) para la extracción automatizada de las facturas de proveedores.

---

## 5. Políticas de Hardening y Seguridad Aplicadas al Core

[cite_start]Para mantener el estándar de seguridad avanzado (Meta 8.5/10) planteado por la dirección de TI, la infraestructura del Core API implementará de forma obligatoria las siguientes tres directrices[cite: 281]:

1.  [cite_start]**Cifrado de Reposo (BitLocker):** El volumen virtual `D:` de la VM, donde se almacenarán los archivos XML temporales, los dumps de contingencia y los logs de auditoría, estará cifrado mediante BitLocker con claves almacenadas en el Active Directory corporativo[cite: 322].
2.  **Aislamiento del Adaptador de Red:** La VM del Core tendrá un interruptor virtual (Virtual Switch) en Hyper-V configurado en modo privado o interno. [cite_start]Bajo ninguna circunstancia se expondrá la IP privada de esta VM directamente en la VLAN 20 de las cajas de las tiendas, protegiendo el backend de intentos de escaneo de puertos[cite: 221, 222].
3.  [cite_start]**Restricción Estricta en Firewall de Windows:** Se creará una regla avanzada de Firewall (`New-NetFirewallRule`) en el sistema operativo de la VM que bloquee cualquier petición entrante al puerto de la API, excepto aquellas cuya dirección IP remota de origen pertenezca explícitamente a la Tailnet corporativa o a la subred del servidor de Base de Datos[cite: 191, 198].