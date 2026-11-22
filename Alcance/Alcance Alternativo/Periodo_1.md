

### Alcance por Componente
* **Middleware ICG (On-Premise):**
  * Conexión directa a la base de datos SQL Server de su ERP ICG actual.
  * Captura de Facturas (con soporte para Órdenes de Compra), Notas Crédito y Notas Débito.
  * Extracción y transformación de los datos crudos a un formato JSON estándar requerido por la API del PT.
* **Core API (Nube o Servidor Local de Integración):**
  * Autenticación segura con la API del PT mediante tokens (Bearer/OAuth) de la empresa.
  * Orquestador de peticiones: Envío de datos al PT y recepción síncrona de la respuesta.
  * Extracción de metadatos retornados por el PT: Captura del CUFE/CUDE, la representación gráfica (PDF) y el XML validado.
  * Sistema de reintentos en caso de interrupciones en la API del PT.
* **Base de Datos de Trazabilidad (Single-Tenant):**
  * Registro de la relación de IDs: `ID_Factura_ICG` ↔ `ID_Transaccion_PT` ↔ `CUFE_DIAN`.
  * Almacenamiento de las URL de descarga del XML y PDF suministrados por el PT.
  * Registro de logs de la comunicación con la API externa (petición enviada y respuesta recibida).
* **Visualizador en Tiempo Real:**
  * Dashboard interno para el equipo contable.
  * Visualización de los estados de procesamiento devueltos por el PT (Procesado, Error de Validación, Pendiente).
  * Botón para forzar la sincronización manual si una factura quedó en estado pendiente en el sistema del PT.
