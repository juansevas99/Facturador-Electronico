# 1. Especificación Detallada del Alcance Funcional (Core Fiscal)

Este módulo detalla las capacidades, funciones y operaciones lógicas específicas que el sistema ejecutará de manera automatizada o a través de la interacción del usuario.

## 1.1. Módulo de Emisión y Ventas (Salidas)

* **Facturación Electrónica de Venta Estándar:** Generación, firma y transmisión síncrona de facturas B2B y B2C, con soporte mandatorio para el bloque de Órdenes de Compra (`OrderReference`) solicitado por clientes corporativos.
* **Documento Equivalente Electrónico POS (Recomendación Crítica para Supermercados):** * *Función:* Dado que operan bajo el modelo de supermercado, el Core debe procesar los tiquetes de caja de ICG directamente como Documentos Equivalentes Electrónicos POS bajo la normativa vigente de la DIAN (Resolución 000165).
  * *Lógica:* El sistema debe diferenciar automáticamente si la venta requiere una Factura Electrónica tradicional (solicitada por el cliente con datos completos) o si se emite un tiquete POS electrónico ágil para consumidor final.
* **Notas Crédito y Débito Automatizadas:**
  * Generación de Notas Crédito para anulación total, rebajas o devoluciones parciales de mercancía, amarradas al CUFE de la factura original.
  * Generación de Notas Débito para cobros adicionales, intereses o errores en menor valor, indexando la factura padre.

---

## 1.2. Módulo de Compras, Proveedores y Gastos (Entradas)

* **Documento Soporte en Adquisiciones a No Obligados:**
  * *Función:* Emisión de documentos electrónicos para legalizar los costos y gastos cuando el supermercado le compra a proveedores que no emiten factura electrónica (ej. pequeños agricultores locales, artesanos o servicios independientes).
  * *Lógica:* Requiere la gestión de una resolución de numeración independiente autorizada por la DIAN y transmisión en formato XML propio.
* **Nota de Ajuste del Documento Soporte (Recomendación Obligatoria):**
  * *Función:* Capacidad de emitir notas de corrección o anulación exclusivas para los Documentos Soporte en caso de errores en la digitación del valor o rescisión del servicio.

---

## 1.3. Módulo de Recepción Automática e IMAP (Cuentas por Pagar)

* **Extractor de Facturas de Compra vía IMAP:**
  * *Función:* El sistema se conectará mediante protocolo seguro (IMAP/OAuth2) al correo electrónico institucional de recepción de facturas de la empresa (ej. `facturacion@supermercado.com`).
  * *Operación:* Escaneará la bandeja de entrada en tiempo real, identificará los correos de proveedores, extraerá el archivo comprimido (.ZIP), descomprimirá y leerá el archivo XML nativo enviado por el proveedor.
* **Validador de XML de Proveedores (Recomendación de Seguridad):**
  * *Función:* Antes de registrar la factura en el visualizador, el Core leerá el XML del proveedor y verificará mediante una lista negra/blanca interna y contra el catálogo de la DIAN si la factura es real, está firmada correctamente y el CUFE es válido.
* **Generador de Eventos RADIAN / Acuses de Compra (Recomendación Crítica de Ley):**
  * *Función:* Para que el supermercado pueda **deducir legalmente los costos y gastos de sus impuestos (IVA y Renta)** en compras a crédito, el Core debe generar y transmitir tres eventos obligatorios a la DIAN:
    1.  *Acuse de recibo de la Factura:* Confirmación de que el correo con el XML fue recibido.
    2.  *Recibo de Bienes y/o Servicios:* Confirmación de que las mercancías del proveedor llegaron físicamente a la sede del supermercado.
    3.  *Aceptación Expresa / Tácita:* Validación final de la factura para que se convierta en título valor.

---

## 1.4. Módulo de Contingencia y Tolerancia a Fallos

* **Gestión de Contingencia Tipo 02 (Falla Tecnológica del Facturador):**
  * *Función:* Si el servidor local pierde conectividad a internet o falla la base de datos de trazabilidad, el Middleware en ICG debe retener las facturas en una cola local. El Core debe permitir la impresión física del formato de contingencia y, al retornar la estabilidad, transmitir de forma masiva y extemporánea los XML sin intervención humana.
* **Cola de Reintentos Inteligente (Queue Management):**
  * *Función:* Si la DIAN rechaza una factura por interrupción temporal de sus servidores (Errores 500, 503 o Timeouts), el Core no debe reportar error al cajero. Debe encolar el documento y reintentar el envío bajo una estrategia de "retroceso exponencial" (cada 1 min, 5 min, 15 min) hasta obtener el *ApplicationResponse* exitoso.

---

## 1.5. Módulo de Administración y Auditoría (Visualizador Frontend)

* **Consola de Conciliación DIAN vs ERP:**
  * *Función:* Pantalla que cruza las ventas totales registradas en ICG contra los XML aceptados por la DIAN al final del día. Emitirá alertas si hay descuadres en centavos por redondeos de impuestos.
* **Descarga Masiva de XML y PDF para Contabilidad:**
  * *Función:* Permitir al área contable exportar en un solo archivo comprimido (.ZIP) todas las facturas de venta o compra de un mes específico, organizadas por carpetas de sucursales, listo para importar en softwares de medios magnéticos o auditorías.