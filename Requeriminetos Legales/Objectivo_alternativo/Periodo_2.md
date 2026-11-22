# 4.3.2. Periodo 2: Escalabilidad y Venta a Clientes (Plataforma Integradora SaaS)
En esta fase, ustedes revenden la plataforma de integración a terceros. Sus clientes de ICG utilizarán la API del PT (ya sea con cuentas individuales o bajo un modelo de subcuentas administradas por ustedes).

### A. Requerimientos Tributarios (Operación Transparente ante la DIAN)
* **Habilitación de Clientes Externos:** Cada nuevo cliente que adquiera su software de integración debe entrar a la DIAN y registrar como modo de operación al **PT Aliado** (no a la empresa de desarrollo de ustedes). Ante la DIAN, el software de ustedes es "invisible"; jurídicamente es solo el canal que el cliente usa para alimentar a su PT.
* **Validación de Reglas de Negocio en el Core:** Para evitar cobros innecesarios por transacciones fallidas en la API del PT (folios rechazados que el PT podría cobrar de igual forma), el Core debe validar que el JSON enviado por el Middleware de ICG cuente con todos los campos obligatorios antes de enviarlo al aliado.
* **Independencia Fiscal de Folios:** El sistema de base de datos debe asegurar que el consumo de créditos o folios de facturación esté estrictamente asignado al `tenant_id` correspondiente, evitando que un cliente consuma el saldo de facturas de otra empresa.

### B. Requerimientos Jurídicos (El Blindaje Tripartito)
* **Cláusula de Limitación de Responsabilidad por Fallas de Terceros:** Este es el requerimiento legal más importante de este modelo. El contrato de reventa del software debe dejar explícitamente claro que **ustedes no controlan la infraestructura de la DIAN ni la del Proveedor Tecnológico**. Si el PT aliado sufre una caída de servidores, retrasos en el firmado o pérdida de datos, la empresa de ustedes queda exonerada de cualquier perjuicio económico, civil o fiscal penalizado al cliente.
* **Garantía del Conector Comercial:** Su responsabilidad jurídica ante el cliente se limita exclusivamente al correcto funcionamiento del Middleware e Integrador (garantizar que el dato que sale de ICG llegue idéntico a la API del PT).
* **Uso Legítimo de API Keys:** El contrato debe prohibir al cliente el uso de las llaves de API provistas para fines diferentes al timbrado de documentos a través de su plataforma, protegiendo la cuenta de distribuidor mayorista de ustedes.

### C. Requerimientos Legales y de Seguridad Corporativa
* **Acuerdo de Transmisión de Datos Personales (Encargado del Tratamiento):** Jurídicamente, en el Periodo 2 ustedes no son los "Dueños" de los datos de los clientes de sus clientes, son los **"Encargados del Tratamiento"**. La ley colombiana exige que sus contratos incluyan un *Acuerdo de Transmisión de Datos*, donde se comprometen a no utilizar esa información comercial, base de datos de clientes o montos de facturación para fines estadísticos, comerciales o de analítica de datos sin autorización explícita.
* **Cifrado de Credenciales de API:** Aunque no guardan firmas digitales (.pfx), guardarán los tokens de acceso y API Keys de las cuentas de sus clientes ante el PT. El requerimiento de ciberseguridad legal exige cifrar estas credenciales en la base de datos para evitar que un atacante externo robe los tokens y altere o consuma los folios de sus clientes.
* **Log de Deslinde Técnico:** La base de datos de trazabilidad debe guardar la marca de tiempo (*Timestamp*) con milisegundos de:
    1. Cuándo llegó el JSON desde ICG a su Core.
    2. Cuándo entregó su Core el JSON a la API del PT.
    3. Cuándo respondió la API del PT.
    * *Propósito:* Si un cliente los culpa de que una factura no se envió a tiempo, este log inmutable sirve como prueba jurídica defensiva para demostrar si la demora fue del ERP del cliente, de su integrador o de la API del PT.