# Matriz de Riesgos y Plan de Contingencia - Objetivo Primario

Este documento detalla la identificación de riesgos, categorización, planes de contingencia y recomendaciones técnicas/operativas para el desarrollo del **Core de Facturación Electrónica Propio** (Objetivo Primario).

---

## 1. Clasificación y Análisis de Riesgos

### 📡 1.1. Riesgos de Telecomunicaciones y Hardware
*   **Caída de Internet (Local o Externa):**
    *   *Descripción:* Pérdida de conectividad en el supermercado (local) o caída del ISP proveedor (externa).
    *   *Impacto:* Crítico (Detiene la transmisión en tiempo real a la DIAN).
    *   *Contingencia:* Activación inmediata de la **Contingencia Tipo 02 (Falla Tecnológica del Facturador)**. Impresión del formato físico de contingencia para el cliente y encolamiento local de los XML para envío extemporáneo una vez retorne la red.
*   **Falla de Nodos (Servidor Central, Caja, Switch/Balanceador):**
    *   *Descripción:* Inoperabilidad del servidor local que aloja el Core Fiscal, del terminal POS (caja), o de elementos activos de red.
    *   *Impacto:* Crítico.
    *   *Contingencia:* Arquitectura con redundancia de hardware. Base de datos local SQLite temporal en cada caja (Middleware) para seguir operando sin conexión al servidor central.
*   **Falla de Autorización / Autenticación:**
    *   *Descripción:* Expiración de tokens locales o fallas en el handshake HTTPS/TLS con los servidores SOAP de la DIAN.
    *   *Impacto:* Alto.
    *   *Contingencia:* Sistema de alertas preventivas (30 días de anticipación) antes de la expiración de firmas y certificados digitales. Log de reintentos síncronos con fallback.

---

### 💻 1.2. Riesgos a Nivel de Software
*   **Lógica No Resuelta o Errores de Código (Bugs):**
    *   *Descripción:* Excepciones no controladas en el Middleware o Core (ej. desbordamiento de memoria, hilos bloqueados).
    *   *Impacto:* Medio-Alto.
    *   *Contingencia:* Monitoreo mediante Health Checks y reinicio automático de servicios de Windows mediante daemons. Logs detallados por transacción.
*   **Fallas de Inicialización de Sistemas:**
    *   *Descripción:* El sistema no levanta tras un reinicio del servidor físico.
    *   *Impacto:* Alto.
    *   *Contingencia:* Configurar el Middleware y Core como Servicios de Windows de inicio automático retrasado (Delayed Start) y dependientes del servicio de Base de Datos.
*   **Requerimientos No Cumplidos por la DIAN (Rechazos):**
    *   *Descripción:* Cambios imprevistos en las reglas sintácticas o semánticas del anexo técnico de la DIAN.
    *   *Impacto:* Alto.
    *   *Contingencia:* Mantener un motor de reglas modular desacoplado del core que permita actualizaciones en caliente sin recompilar toda la aplicación.

---

### 💾 1.3. Riesgos a Nivel de Datos
*   **Confidencialidad de la Información:**
    *   *Descripción:* Acceso no autorizado a datos de facturación de clientes o información financiera sensible.
    *   *Impacto:* Alto.
    *   *Contingencia:* Cifrado de base de datos en reposo y uso mandatorio de HTTPS/TLS 1.3 para todas las comunicaciones de red.
*   **Respaldo y Persistencia de Datos:**
    *   *Descripción:* Pérdida de base de datos de trazabilidad fiscal por daño en disco duro.
    *   *Impacto:* Crítico.
    *   *Contingencia:* Estrategia de copias de seguridad automáticas (Backups diarios en caliente) con replicación en una ubicación de red externa o nube.
*   **Riesgo de Contabilización o Aritmética (Redondeos):**
    *   *Descripción:* Descuadres en centavos entre el valor calculado en ICG, el XML de la DIAN, y el libro contable de la empresa.
    *   *Impacto:* Medio (Genera glosas fiscales y rechazos DIAN).
    *   *Contingencia:* Implementación de la librería matemática de redondeo oficial de la DIAN (métodos de truncamiento y aproximación basados en el anexo técnico UBL 2.1).

---

### 🔒 1.4. Riesgos de Seguridad
*   **Alteración de Datos (Antes de la Transmisión):**
    *   *Descripción:* Manipulación maliciosa de los precios, impuestos o destinatarios en la base de datos de ICG antes de ser leídos por el Middleware.
    *   *Impacto:* Crítico.
    *   *Contingencia:* Implementar sumas de comprobación (checksums) criptográficas en las transacciones de ICG y auditorías automáticas de discrepancia.
*   **Alteración de Datos (Después de la Transmisión):**
    *   *Descripción:* Manipulación del archivo PDF o XML aprobado tras la confirmación de la DIAN.
    *   *Impacto:* Alto.
    *   *Contingencia:* La firma digital XAdES-BES en el XML garantiza la no alteración del documento (cualquier cambio invalida la firma). Para el PDF, aplicar firmas visuales o marcas de agua hash.
*   **Robo de Información:**
    *   *Descripción:* Fuga del certificado digital (`.pfx`) o base de datos de adquirentes.
    *   *Impacto:* Crítico.
    *   *Contingencia:* Almacenamiento del certificado digital en bóvedas de claves seguras (ej. Windows Certificate Store con permisos restringidos a nivel de sistema).

---

### 👥 1.5. Riesgos Operativos
*   **Errores del Operador (Cajero):**
    *   *Descripción:* Errores al digitar NITs incorrectos, omisión del correo electrónico del cliente o emisión errónea de facturas POS.
    *   *Impacto:* Medio.
    *   *Contingencia:* Interfaz de caja con validadores en tiempo real (Luhn para dígitos de verificación, expresiones regulares para correos electrónicos y NITs).

---

### ⚖️ 1.6. Riesgos Fiscales
*   **Extemporaneidad en la Transmisión:**
    *   *Descripción:* Enviar documentos fuera del plazo de ley establecido por la DIAN (especialmente al salir de contingencias).
    *   *Impacto:* Alto (Sanciones económicas).
    *   *Contingencia:* Cola inteligente de retransmisión de contingencia que procese los documentos en lotes con prioridad cronológica inmediata una vez se restablezca el servicio.
*   **Desactualización de Protocolos Legales:**
    *   *Descripción:* Pérdida de validez del sistema por no adoptar a tiempo nuevas resoluciones.
    *   *Impacto:* Crítico.
    *   *Contingencia:* Contrato de soporte técnico preventivo con alertas legales del estado del ecosistema de la DIAN.
*   **Riesgo de Numeración:**
    *   *Descripción:* Agotamiento de rangos de numeración autorizados por la DIAN o solapamiento de resoluciones viejas y nuevas en el punto de venta.
    *   *Impacto:* Alto.
    *   *Contingencia:* Bloqueo preventivo en el frontend al llegar al 95% del rango autorizado, alertando al área contable para tramitar una nueva resolución.

*   **Modificación del Anexo Técnico por parte de la DIAN:**
    *   *Descripción:* La DIAN actualiza sus normativas y anexos técnicos (UBL, reglas de validación) frecuentemente, añadiendo o quitando campos obligatorios.
    *   *Impacto:* Crítico (Rechazo masivo de documentos si el XML se desfasa de la versión oficial).
    *   *Contingencia:* Arquitectura de plantillas configurables y paramétricas que permita mapear y alterar la construcción del XML de manera ágil sin tener que recompilar todo el software core.
---

## 2. Recomendaciones Estratégicas para el Ecosistema

1.  **Aislamiento del Middleware (Caché Offline):** El conector/middleware instalado en cada servidor de caja de ICG debe contar con una base de datos local embebida (como SQLite). Si el Core de Facturación o el internet fallan, la venta debe continuar en la caja de forma fluida, y el middleware sincronizará en segundo plano cuando la conexión vuelva.
2.  **Protección de la Clave Privada:** El archivo `.pfx` del certificado digital no debe estar expuesto directamente en el sistema de archivos de forma pública. Se debe cifrar en base de datos o cargar directamente en el almacén de certificados protegidos del sistema operativo Windows, limitando el acceso únicamente al proceso del Core.
3.  **Monitoreo Transaccional Automatizado:** Implementar un visualizador de logs que no solo registre errores técnicos (ej. *NullPointerException*), sino errores lógicos de negocio (ej. *"Factura X rechazada por DIAN por código 90 - Nit inválido"*). Esto permite al equipo administrativo corregir problemas de datos sin involucrar a los desarrolladores.
4.  **Simulacro de Contingencia DIAN:** Antes de la salida a producción, realizar pruebas desconectando el internet del servidor central a mitad del día para asegurar que las cajas conmuten a Contingencia Tipo 02 sin interrupciones para el cajero y que los XML se encolen y transmitan correctamente al restablecer la red.
