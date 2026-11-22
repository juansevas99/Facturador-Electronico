

### Alcance por Componente (Evolución)
* **Middleware ICG Empaquetado:**
  * Conversión del código a un servicio de Windows autoinstalable.
  * Interfaz de configuración donde el nuevo cliente introduce sus credenciales locales de ICG y la API Key de su plataforma integradora.
* **Core API Multi-Tenant (Nube):**
  * **Módulo de Mapeo Dinámico de Credenciales:** El Core debe asociar cada `tenant_id` (cliente) con sus credenciales específicas de la API del PT (cada cliente tiene sus propias llaves de acceso ante el proveedor).
  * **Traductor de Errores de API:** Capacidad de capturar los códigos de error nativos del PT y normalizarlos en un formato estándar antes de enviarlos al visualizador.
  * Panel de control maestro para monitorear el flujo transaccional de todos los clientes conectados.
* **Base de Datos de Trazabilidad (Multi-Tenant):**
  * Aislamiento estricto de datos mediante indexación obligatoria por `tenant_id`.
  * Optimización de almacenamiento guardando únicamente registros transaccionales livianos (las facturas físicas y los XML permanecen alojados en la nube del PT contratado).
* **Visualizador Cliente Final:**
  * Portal web multi-inquilino donde cada cliente externo inicia sesión para ver el historial de sus facturas tramitadas a través del conector.
  * Herramientas de diagnóstico para que el cliente final vea si un documento falló debido a datos mal digitados en ICG o por caídas de la API del PT.