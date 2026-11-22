## 6.2. Costos del Periodo 2: Escalabilidad y Venta a Clientes (Plataforma Integradora SaaS)
Al revender la solución a terceros, ustedes se convierten en "Distribuidores/Aliados" del PT. Su Core en la nube solo actúa como un enrutador de tráfico JSON, lo que relaja los requerimientos de hardware.

#### A. Costo Transaccional Mayorista (El motor del negocio)
* **Bolsa de Folios Corporativa (Volumen Masivo):** Para poder revender, ustedes le compran al PT paquetes gigantescos de folios (ej. desde 100.000 hasta 1'000.000 de facturas). Al comprar en masa, el PT les otorga tarifas de distribuidor.
    * *Costo Estimado:* **\$15 a \$30 COP por factura** (OpEx Variable). *Nota: Este costo se traslada al cliente final con un margen de ganancia (ej. se compra a \$20 y se revende a \$100).*

#### B. Conectividad e Infraestructura Ligeras
* **Canal de Internet / Hosting:** Como el Core no procesa firmas pesadas ni almacena los XML por 5 años (el PT tiene la obligación legal de guardarlos en sus servidores), los requerimientos de almacenamiento se reducen en un 80%. Pueden operar con sus servidores actuales o un plan de hosting en la nube muy económico.
    * *Costo Estimado:* **\$150.000 a \$400.000 COP mensuales** (OpEx).

#### C. Software de Soporte y Monitoreo
* **Monitoreo de APIs (Uptime):** Herramientas para vigilar que la API del PT responda rápido y alertar si el proveedor intermedio tiene caídas.
    * *Costo Estimado:* **\$50.000 - \$150.000 COP mensuales** (OpEx).
* **Plataforma de Soporte (Ticketing):** Requerido para atender incidencias de clientes externos.
    * *Costo Estimado:* **\$120.000 COP mensuales** por agente (OpEx).

#### D. Costos Legales (Un solo pago inicial)
* **Contrato Tripartito / Términos de Servicio:** Se requiere estructurar contractualmente que ustedes proveen el software de integración (Middleware), pero que el servicio fiscal lo presta el PT aliado. Esto los libera de demandas si el PT se cae o pierde información.
    * *Costo Estimado:* **\$1'000.000 - \$2'000.000 COP** (Pago único - CapEx).