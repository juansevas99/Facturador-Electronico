##Costos del Periodo 2: Escalabilidad y Venta a Clientes (Plataforma SaaS)
Al abrir los servidores locales para recibir conexiones de múltiples empresas externas, la infraestructura debe robustecerse para garantizar seguridad y un Acuerdo de Nivel de Servicio (SLA) del 99.9%.

#### A. Infraestructura y Conectividad (Servidores Locales Robustecidos)
* **Canal Dedicado de Internet (Simétrico + IPs Fijas):** No se puede operar con internet comercial. Se requiere un canal corporativo que garantice estabilidad si se caen las líneas normales.
    * *Costo Estimado:* **\$600.000 a \$1'500.000 COP mensuales** (OpEx).
* **Sistema de Respaldo Eléctrico (UPS Corporativa):** Inversión única si los servidores actuales no cuentan con una autonomía superior a 2 horas ante cortes de luz.
    * *Costo Estimado:* **\$2'000.000 a \$4'000.000 COP** (Inversión única - CapEx).

#### B. Seguridad y Custodia (Multi-Tenant)
* **Bóveda de Llaves Criptográficas (Cifrado de Firmas):** Para almacenar de forma ultra segura los archivos `.pfx` de los clientes futuros. Se recomienda integrar el Core con servicios como *Azure Key Vault* o *AWS KMS*.
    * *Costo Estimado:* **\$30.000 - \$100.000 COP mensuales** (Variable según el volumen de firmas - OpEx).

#### C. Software de Monitoreo y Soporte
* **Herramientas de Observabilidad (Logs y Alertas):** Para que tu equipo detecte caídas antes de que los clientes llamen (ej. Datadog, New Relic, o configuración avanzada de Grafana/Prometheus de código abierto).
    * *Costo Estimado:* **\$100.000 - \$300.000 COP mensuales** (OpEx).
* **Sistema de Ticketing (Soporte Técnico):** Plataforma para atender solicitudes de errores de clientes (ej. Freshdesk, Zendesk o Jira Service Desk).
    * *Costo Estimado:* **\$120.000 COP mensuales** per cápita de soporte (OpEx).

#### D. Costos Legales y de Cumplimiento (Un solo pago inicial)
* **Redacción de Contratos SaaS y SLAs:** Abogado especialista para blindar a tu empresa de demandas si la DIAN o tus servidores fallan.
    * *Costo Estimado:* **\$1'500.000 - \$3'000.000 COP** (Pago único - CapEx).
* **Registro de Bases de Datos (Habeas Data - SIC):** Cumplimiento legal por almacenar datos financieros de terceros.
    * *Costo Estimado:* **\$0 - \$500.000 COP** (Trámite legal).

### 5.3. Resumen Financiero del Periodo 2 (Para el Modelo de Negocio)

* **Inversión Inicial Extra (CapEx):** \$3'500.000 - \$7'500.000 COP (Contratos legales, adecuación eléctrica, licencias iniciales).
* **Costo Fijo Mensual de Operación (OpEx):** \$950.000 - \$2'100.000 COP (Internet dedicado, herramientas de monitoreo, bóveda de seguridad).
* **Costo Variable por Factura:** **\$0 COP** (A excepción del correo masivo que cuesta centavos de peso. El certificado digital de firma lo compra y lo paga cada cliente final por su cuenta).