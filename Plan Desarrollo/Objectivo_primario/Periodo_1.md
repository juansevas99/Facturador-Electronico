# 7. Roadmap de Desarrollo: Periodo 1 (Implementación Interna)

Este roadmap detalla el ciclo de vida del desarrollo técnico para el Producto Mínimo Viable (MVP), diseñado para sustituir al proveedor actual y asumir la facturación electrónica propia directa ante la DIAN.

---

## 7.1. Cronograma de Fases y Entregables

### 📌 Fase 1: Ingeniería de Requisitos, Estado Actual y Diseño Base
**Objetivo:** Levantar la arquitectura técnica actual de la empresa, mapear la base de datos de ICG y definir los contratos de datos entre componentes.

* **Actividades Clave:**
    * **Auditoría de Infraestructura:** Mapeo de capacidades de los servidores físicos locales actuales, configuración de redes internas y asignación de IPs públicas fijas para pruebas.
    * **Ingeniería de Reversa / Diccionario de Datos ICG:** Identificar las tablas nativas de SQL Server de ICG donde se almacenan las facturas de venta, notas crédito (devoluciones), notas débito y el campo de Orden de Compra.
    * **Definición del Contrato JSON:** Diseñar el esquema JSON estándar unificado que el Middleware extraerá de ICG y que el Core esperará recibir.
    * **Diseño de Arquitectura de Software:** Diagramación de diagramas de secuencia UML para el flujo del documento (ICG ➔ Middleware ➔ Core ➔ DIAN).
* **Entregables (Milestones):**
    * Documento de diccionario de datos (Tablas e hilos de ICG).
    * Esquema JSON del contrato de datos (`invoice_schema.json`).
    * Diagrama de red y arquitectura local aprobado.

---

### 📌 Fase 2: Desarrollo del Core de Facturación Electrónica (El Cerebro)
**Objetivo:** Construir el motor fiscal agnóstico que procese los datos, genere los XMLs legales, los firme criptográficamente y se comunique con la DIAN.

* **Actividades Clave:**
    * **Motor de Validación de Reglas:** Programar las validaciones previas (formatos de NIT, cálculos de impuestos IVA/INC, obligatoriedad de campos según el anexo técnico).
    * **Constructor de XML (UBL 2.1):** Desarrollar el serializador que transforma el JSON recibido en la estructura XML jerárquica exigida por la DIAN.
    * **Módulo Criptográfico (Firma Digital):** Implementar la librería de firmado XAdES-BES (PKCS#7) utilizando el certificado digital `.pfx` de la empresa.
    * **Calculador de CUFE/CUDE y QR:** Programar el algoritmo SHA-384 para el encadenamiento de los códigos únicos y la cadena de texto del código QR.
    * **Cliente Web Services (SOAP):** Construir el cliente HTTP para consumir los Web Services SOAP síncronos de la DIAN (`RecepcionFactura`).
    * **Módulo de Notificación SMTP:** Integrar la API del servicio de correo masivo (ej. Amazon SES) para disparar el correo al cliente con los adjuntos (XML firmado + PDF).
* **Entregables (Milestones):**
    * API del Core Fiscal funcional en ambiente local.
    * XML generado que supera las herramientas de validación sintáctica.
    * Módulo de firmado digital validado.

---

### 📌 Fase 3: Desarrollo del Add-on / Middleware para ICG
**Objetivo:** Construir el agente ligero que "escuche" al ERP ICG y extraiga la información en tiempo real hacia el Core.

* **Actividades Clave:**
    * **Mecanismo de Escucha (Trigger / Polling):** Desarrollar el servicio de Windows que monitorea la base de datos SQL Server de ICG para detectar cierres de facturas o generación de notas.
    * **Extractor y Mapeador:** Programar la lógica que toma los registros dispersos en las tablas de ICG y los empaqueta en el JSON unificado definido en la Fase 1.
    * **Cliente API de Comunicación:** Programar el envío HTTPS del JSON hacia el endpoint del Core Fiscal.
    * **Manejo de Errores y Cola Local:** Desarrollar una caché local (ej. SQLite o archivos planos) para encolar las facturas si el servidor del Core no responde, garantizando que el punto de venta de ICG nunca se congele.
* **Entregables (Milestones):**
    * Servicio de Windows (Middleware) instalado y ejecutándose en el servidor de ICG.
    * Logs de extracción de datos exitosos desde ICG hacia formato JSON.

---

### 📌 Fase 4: Desarrollo del Visualizador de Facturación (Frontend)
**Objetivo:** Proveer una interfaz gráfica intuitiva para que el equipo contable y técnico audite el estado de los documentos fiscales.

* **Actividades Clave:**
    * **Interfaz de Dashboard:** Crear la vista principal con indicadores clave (Facturas Emitidas, Aprobadas, Rechazadas, En Contingencia).
    * **Grilla Transaccional de Trazabilidad:** Desarrollar la tabla de búsqueda con filtros por Fecha, NIT de cliente, Número de Factura e ID de ICG.
    * **Consola de Errores Traducida:** Mapear los códigos de error técnicos devueltos por la DIAN (ej. "Regla 90") a mensajes claros en lenguaje humano para el usuario contable.
    * **Acciones de Control:** Programar los botones de "Reintentar Envío", "Reenviar Correo al Adquirente" y "Descargar XML/PDF".
* **Entregables (Milestones):**
    * Aplicación Web (Visualizador) desplegada y conectada a la Base de Datos de Trazabilidad.
    * Pruebas de usuario con el equipo contable interno completadas con éxito.

---

### 🏁 Fase 5: Habilitación ante la DIAN y Paso a Producción (Hito de Cierre)
**Objetivo:** Ejecutar las pruebas oficiales ante el estado y realizar el "Go-Live" definitivo.

* **Actividades Clave:**
    * Ingreso al ambiente de habilitación en el portal de la DIAN con el token de la empresa.
    * Inyección del `TestSetID` en el Core Fiscal.
    * Ejecución del set de pruebas automatizado (envío masivo de facturas, notas crédito y débito de prueba).
    * Sincronización de la nueva resolución de producción en ICG.
    * Apagado definitivo del conector del proveedor anterior y encendido de la solución propia en producción.