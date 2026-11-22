# Campos Obligatorios: Documento Equivalente Electrónico POS (Anexo 1.0)

Basado en el análisis estricto de los XML de la Caja de Herramientas de la DIAN (como `POS.xml` y `POS ICUI.xml`) y el estándar UBL 2.1, a continuación se detallan los bloques y campos que **SIEMPRE deben existir** en el archivo XML para que sea validado exitosamente.

Si falta alguno de estos campos obligatorios (Ocurrencia `1..1`), la DIAN rechazará el documento con un error de validación de XSD.

---

## 1. Cabecera y Metadatos Básicos
Estos son los campos que identifican el tipo de documento, la fecha y el identificador único.

*   **`<cbc:UBLVersionID>`**: Siempre debe ser `UBL 2.1`.
*   **`<cbc:CustomizationID>`**: Siempre debe ser `10`.
*   **`<cbc:ProfileID>`**: `DIAN 2.1: Documento Equivalente POS`.
*   **`<cbc:ProfileExecutionID>`**: Ambiente de ejecución (`1` para Producción, `2` para Pruebas).
*   **`<cbc:ID>`**: El número consecutivo del tiquete POS, incluyendo el prefijo (Ej: `EPOS002`).
*   **`<cbc:UUID>`**: El Código Único de Documento Electrónico (CUDE). Debe llevar el atributo `schemeName="CUDE-SHA384"`.
*   **`<cbc:IssueDate>`**: Fecha de expedición (Formato `YYYY-MM-DD`).
*   **`<cbc:IssueTime>`**: Hora de expedición (Formato `HH:MM:SS-05:00`).
*   **`<cbc:InvoiceTypeCode>`**: Siempre debe ser `20` para indicar que es un POS.
*   **`<cbc:DocumentCurrencyCode>`**: La moneda, siempre `COP`.
*   **`<cbc:LineCountNumeric>`**: La cantidad total de líneas (productos) que tiene el tiquete.

## 2. Extensiones de la DIAN (`<ext:UBLExtensions>`)
Es el contenedor de las reglas exclusivas de Colombia.

### 2.1 DianExtensions (`<sts:DianExtensions>`)
*   **`<sts:InvoiceControl>`**: Información de la resolución de facturación (Número de autorización, fechas de inicio/fin, prefijo y rangos).
*   **`<sts:SoftwareProvider>`**: NIT del proveedor tecnológico y el Software PIN/ID.
*   **`<sts:SoftwareSecurityCode>`**: Hash SHA-384 que valida la procedencia del software.
*   **`<sts:QRCode>`**: La URL completa que concatena el CUDE para que el cliente pueda escanear el tiquete impreso.

### 2.2 Extensión Punto de Venta (`<PuntoVenta>`)
Exclusiva del POS. Siempre debe llevar:
*   `PlacaCaja`: Identificador físico de la caja (Ej: Caja 01).
*   `UbicaciónCaja`: Sede o almacén (Ej: CEDRITOS 1).
*   `Cajero`: Nombre de quien operó la caja.
*   `TipoCaja`: Principal, apoyo, auto-pago, etc.
*   `CódigoVenta`: Consecutivo interno del sistema de ventas.
*   `SubTotal`: Valor antes de impuestos de toda la tirilla.

## 3. Identificación de los Actores

### 3.1 Emisor (`<cac:AccountingSupplierParty>`)
Los datos del supermercado.
*   **NIT** (`<cbc:CompanyID>`) y Razón Social (`<cbc:RegistrationName>`).
*   **Dirección física** (`<cac:PhysicalLocation>`).
*   **Responsabilidades Fiscales** (`<cbc:TaxLevelCode>`, Ej: `O-13` para Gran Contribuyente, o `O-47` régimen ordinario).
*   **Tributos** (`<cac:TaxScheme>`): Generalmente `01` (IVA).

### 3.2 Adquirente / Cliente (`<cac:AccountingCustomerParty>`)
Incluso si es una venta rápida donde el cliente no da sus datos, **este bloque es obligatorio**.
*   **Si el cliente da datos:** Se llena con su Cédula/NIT, Nombre y correo.
*   **Si es venta rápida (Anónimo):** 
    *   `<cbc:ID>`: `222222222222` (El NIT genérico de Consumidor Final).
    *   `<cbc:Name>`: `Consumidor Final`.

## 4. Totales y Pagos

### 4.1 Medios de Pago (`<cac:PaymentMeans>`)
*   **`<cbc:PaymentMeansCode>`**: Cómo pagó el cliente. Ej: `10` (Efectivo), `48` (Tarjeta de Crédito), `49` (Tarjeta Débito).

### 4.2 Resumen de Impuestos (`<cac:TaxTotal>`)
Deben sumarizarse TODOS los impuestos cobrados en la tirilla.
*   Total del impuesto (`<cbc:TaxAmount>`).
*   Base gravable (`<cbc:TaxableAmount>`).
*   Porcentaje o Tarifa (`<cbc:Percent>` para IVA/ICUI, `<cbc:PerUnitAmount>` para IBUA).
*   Identificador del impuesto (`<cbc:ID>`: `01` IVA, `34` IBUA, `35` ICUI, `22` Bolsas).

### 4.3 Total a Pagar (`<cac:LegalMonetaryTotal>`)
El balance final del tiquete.
*   **`<cbc:LineExtensionAmount>`**: Total Bruto (Cantidad x Precio sin impuestos).
*   **`<cbc:TaxExclusiveAmount>`**: Base gravable total.
*   **`<cbc:TaxInclusiveAmount>`**: Total con todos los impuestos sumados.
*   **`<cbc:PayableAmount>`**: Total final a pagar por el cliente (debe coincidir con el `TaxInclusiveAmount` menos descuentos globales si los hay).

## 5. Detalle de los Productos (`<cac:InvoiceLine>`)
Debe existir al menos un bloque de estos por cada producto vendido.
*   **`<cbc:ID>`**: Consecutivo de la línea (1, 2, 3...).
*   **`<cbc:InvoicedQuantity>`**: Cantidad vendida y la unidad de medida (Ej: `NIU` para unidades, `KGM` para kilos).
*   **`<cbc:LineExtensionAmount>`**: Valor total de la línea (Cantidad x Precio unitario sin impuestos).
*   **Impuestos de la Línea** (`<cac:TaxTotal>`): Es obligatorio discriminar qué impuestos aplican a este producto específico.
*   **Descripción** (`<cbc:Description>`): Nombre del producto (Ej: `Coca cola 3.5LTS`).
*   **Código de Barras/SKU** (`<cac:StandardItemIdentification>`): El EAN o código PLU interno del supermercado.
*   **Precio Unitario** (`<cac:Price>`): El valor de 1 sola unidad del producto sin impuestos.
