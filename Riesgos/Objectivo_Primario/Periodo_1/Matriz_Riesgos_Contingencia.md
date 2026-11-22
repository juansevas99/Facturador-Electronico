# Matriz de Riesgos y Plan de Contingencia - Proyecto Facturador Electrónico Ramírez

Este documento consolida la matriz de riesgos y planes de contingencia para el **Core de Facturación Electrónica**, basándose estrictamente en los riesgos previamente identificados por el equipo de diseño y articulados con la nueva arquitectura desacoplada (Core API Centralizado).

---

## 1. Riesgos de Telecomunicaciones y Hardware

### 1.1 Caída de Internet (Local o Externa)
> [!WARNING]
> **Riesgo:** Pérdida de conectividad en el supermercado (local) o caída del ISP proveedor (externa).
> **Impacto:** Crítico (Detiene la transmisión en tiempo real a la DIAN).

**Plan de Contingencia:**
- Activación inmediata de la **Contingencia Tipo 02 (Falla Tecnológica del Facturador)**.
- Impresión del formato físico de contingencia para el cliente.
- Encolamiento local de las ventas (Middleware de caja) para envío asíncrono al Core API una vez retorne la red.

### 1.2 Falla de Nodos (Servidor Central, Caja, Switch/Balanceador)
> [!CAUTION]
> **Riesgo:** Inoperabilidad del servidor local que aloja el Core Fiscal, del terminal POS (caja), o de elementos activos de red.
> **Impacto:** Crítico.

**Plan de Contingencia:**
- Arquitectura con redundancia de hardware.
- Base de datos local SQLite temporal en cada caja (Middleware) para seguir operando sin depender de la conexión al servidor central (`SRV-BD-01`).

### 1.3 Falla de Autorización / Autenticación
> [!NOTE]
> **Riesgo:** Expiración de tokens locales o fallas en el handshake HTTPS/TLS con los servidores SOAP de la DIAN.
> **Impacto:** Alto.

**Plan de Contingencia:**
- Sistema de alertas preventivas (30 días de anticipación) antes de la expiración de firmas y certificados digitales.
- Log de reintentos síncronos con fallback en el Core API.

---

## 2. Riesgos a Nivel de Software

### 2.1 Lógica No Resuelta o Errores de Código (Bugs)
> [!WARNING]
> **Riesgo:** Excepciones no controladas en el Middleware o Core (ej. desbordamiento de memoria, hilos bloqueados).
> **Impacto:** Medio-Alto.

**Plan de Contingencia:**
- Monitoreo mediante Health Checks y reinicio automático de servicios de Windows mediante daemons.
- Logs detallados por transacción.

### 2.2 Fallas de Inicialización de Sistemas
> [!WARNING]
> **Riesgo:** El sistema no levanta tras un reinicio del servidor físico.
> **Impacto:** Alto.

**Plan de Contingencia:**
- Configurar el Middleware y Core como Servicios de Windows de inicio automático retrasado (Delayed Start) y dependientes del servicio de Base de Datos.

### 2.3 Requerimientos No Cumplidos por la DIAN (Rechazos)
> [!IMPORTANT]
> **Riesgo:** Errores de validación semántica al enviar el XML a la DIAN.
> **Impacto:** Alto.

**Plan de Contingencia:**
- El **DianXSDValidator** audita matemáticamente el XML contra los XSD oficiales de la DIAN *antes* de enviarlo, reduciendo a cero los rechazos por estructura.
- Mantener el motor de reglas desacoplado del core (Arquitectura Hexagonal) para actualizaciones en caliente.

---

## 3. Riesgos a Nivel de Datos

### 3.1 Confidencialidad de la Información
> [!CAUTION]
> **Riesgo:** Acceso no autorizado a datos de facturación de clientes o información financiera sensible.
> **Impacto:** Alto.

**Plan de Contingencia:**
- Cifrado de base de datos en reposo y uso mandatorio de HTTPS/TLS 1.3 para todas las comunicaciones de red.

### 3.2 Respaldo y Persistencia de Datos
> [!CAUTION]
> **Riesgo:** Pérdida de base de datos de trazabilidad fiscal por daño en disco duro.
> **Impacto:** Crítico.

**Plan de Contingencia:**
- Estrategia de copias de seguridad automáticas (Backups diarios en caliente) con replicación en una ubicación de red externa o nube (vía USB al almacenamiento externo documentado `STG-EXT-01`).

### 3.3 Riesgo de Contabilización o Aritmética (Redondeos)
> [!WARNING]
> **Riesgo:** Descuadres en centavos entre el valor calculado en ICG, el XML de la DIAN, y el libro contable de la empresa.
> **Impacto:** Medio.

**Plan de Contingencia:**
- Implementación de la librería matemática de redondeo oficial de la DIAN en la capa de infraestructura del Core API.

---

## 4. Riesgos de Seguridad

### 4.1 Alteración de Datos (Antes de la Transmisión)
> [!CAUTION]
> **Riesgo:** Manipulación maliciosa de los precios en la BD de ICG antes de ser leídos por el Middleware.
> **Impacto:** Crítico.

**Plan de Contingencia:**
- Implementar sumas de comprobación (checksums) criptográficas en las transacciones de ICG y auditorías automáticas de discrepancia.

### 4.2 Alteración de Datos (Después de la Transmisión)
> [!CAUTION]
> **Riesgo:** Manipulación del archivo PDF o XML aprobado tras la confirmación de la DIAN.
> **Impacto:** Alto.

**Plan de Contingencia:**
- La firma digital XAdES-BES en el XML garantiza la no alteración del documento. Para el PDF, aplicar firmas visuales o marcas de agua hash.

### 4.3 Robo de Información (Certificado Digital)
> [!CAUTION]
> **Riesgo:** Fuga del certificado digital (`.pfx`).
> **Impacto:** Crítico.

**Plan de Contingencia:**
- Almacenamiento del certificado digital en bóvedas de claves seguras en el servidor central (Core API) y nunca distribuirlo a los terminales remotos de las 13 sedes.

---

## 5. Riesgos Operativos

### 5.1 Errores del Operador (Cajero)
> [!NOTE]
> **Riesgo:** Errores al digitar NITs incorrectos, omisión de correos o emisión errónea de POS.
> **Impacto:** Medio.

**Plan de Contingencia:**
- Interfaz de caja con validadores en tiempo real (Luhn para dígitos de verificación, expresiones regulares para correos electrónicos y NITs).

---

## 6. Riesgos Fiscales

### 6.1 Extemporaneidad en la Transmisión
> [!WARNING]
> **Riesgo:** Enviar documentos fuera del plazo de ley (48 horas después de una contingencia).
> **Impacto:** Alto (Sanciones económicas).

**Plan de Contingencia:**
- Cola inteligente (Async Job en el Core API) de retransmisión de contingencia que procese los documentos en lotes con prioridad cronológica inmediata una vez se restablezca el servicio.

### 6.2 Desactualización de Protocolos Legales
> [!CAUTION]
> **Riesgo:** Pérdida de validez del sistema por no adoptar a tiempo nuevas resoluciones.
> **Impacto:** Crítico.

**Plan de Contingencia:**
- Contrato de soporte técnico preventivo con alertas legales del estado del ecosistema de la DIAN.

### 6.3 Riesgo de Numeración
> [!CAUTION]
> **Riesgo:** Agotamiento de rangos de numeración autorizados por la DIAN o solapamiento de resoluciones viejas y nuevas en el punto de venta.
> **Impacto:** Alto.

**Plan de Contingencia:**
- Bloqueo preventivo en el frontend al llegar al 95% del rango de la resolución autorizada, alertando al área contable.

### 6.4 Modificación del Anexo Técnico por parte de la DIAN
> [!CAUTION]
> **Riesgo:** La DIAN añade o quita campos obligatorios en el UBL 2.1 o extensiones.
> **Impacto:** Crítico (Rechazo masivo de documentos si el XML se desfasa de la versión oficial).

**Plan de Contingencia:**
- **Diseño Desacoplado:** Al tener la construcción del XML centralizada y puramente en `infrastructure/xml_builder.py`, el Core API puede adoptar los nuevos esquemas de la DIAN en horas sin afectar la lógica de negocio ni las bases de datos distribuidas.

---

## 7. Recomendaciones Estratégicas Adicionales

Para asegurar la operatividad de este plan, se recomienda implementar las siguientes acciones preventivas previas a la salida en vivo:

1. **Aislamiento del Middleware (Caché Offline):** El conector/middleware instalado en cada servidor de caja de ICG debe contar con una base de datos local embebida (como SQLite). Si el Core de Facturación o el internet fallan, la venta debe continuar en la caja de forma fluida.
2. **Protección de la Clave Privada:** El archivo `.pfx` no debe estar expuesto. Se debe cargar directamente en el almacén de certificados protegidos de Windows.
3. **Monitoreo Transaccional Automatizado:** Implementar un visualizador de logs que registre errores lógicos de negocio (ej. *"Factura X rechazada por DIAN por código 90"*), no solo errores técnicos.
4. **Simulacro de Contingencia DIAN:** Antes de salir a producción, realizar pruebas desconectando deliberadamente el internet del servidor central a mitad del día para asegurar que el sistema conmute correctamente a Contingencia y los XML se encolen.
