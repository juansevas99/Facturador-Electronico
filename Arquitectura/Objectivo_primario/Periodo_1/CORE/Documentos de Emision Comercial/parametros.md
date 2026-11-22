# Especificación Técnica: Parámetros del XML para Facturas de Venta (UBL 2.1)

Este documento detalla los parámetros obligatorios y opcionales que deben inyectarse dentro de la estructura XML de una Factura Electrónica de Venta (Código `01`) antes de ser empaquetada y enviada al WebService de la DIAN.

---

## 1. Parámetros Globales del Documento (Cabecera)

Estos parámetros definen el tipo de documento, su vigencia y las divisas utilizadas en la transacción.

| Parámetro Técnico (UBL 2.1) | Tipo de Dato | Valor / Formato | Descripción |
| :--- | :---: | :--- | :--- |
| `<cbc:CustomizationID>` | String | `10` | Indica el tipo de operación. `10` es el estándar para venta nacional. |
| `<cbc:ProfileExecutionID>` | String | `2` | Ambiente de destino. `1` para Producción, `2` para Habilitación/Pruebas. |
| `<cbc:ID>` | String | Ej: `SETP990000001` | Número de factura. Prefijo + Consecutivo (Sin espacios). |
| `<cbc:IssueDate>` | Fecha | `AAAA-MM-DD` | Fecha de emisión física en la caja registradora. |
| `<cbc:IssueTime>` | Hora | `HH:MM:SS-05:00` | Hora de emisión. Debe incluir la zona horaria de Colombia (-05:00). |
| `<cbc:InvoiceTypeCode>` | String | `01` | **Código fundamental.** Indica que es una Factura Electrónica de Venta. |
| `<cbc:DocumentCurrencyCode>`| String | `COP` | Divisa de la transacción (Pesos Colombianos). |

---

## 2. Parámetros del Emisor (`<cac:AccountingSupplierParty>`)
Representa los datos fijos de tu empresa de supermercados como vendedor.

* **`<cbc:AdditionalAccountID>`**: Tipo de persona. `1` para Persona Jurídica, `2` para Persona Natural.
* **`<cac:Party>/<cac:PartyTaxScheme>/<cbc:RegistrationName>`**: Razón social exacta de la empresa tal como figura en el RUT.
* **`<cac:Party>/<cac:PartyTaxScheme>/<cbc:CompanyID>`**: NIT de la empresa. El atributo `schemeID` lleva el Dígito de Verificación (DV).
* **`<cac:Party>/<cac:PartyTaxScheme>/<cac:TaxScheme>/<cbc:ID>`**: Código de tributo del emisor (Ej: `01` para IVA).
* **`<cac:Party>/<cac:PartyLegalEntity>/<cac:CorporateRegistrationScheme>/<cbc:ID>`**: Prefijo de la resolución asignada (Ej: `SETP`).
* **`<cac:PhysicalLocation>`**: Dirección física de la sede central o de la sucursal donde se generó la venta (País `CO`, Departamento `11`, Municipio `11001` para Bogotá).

---

## 3. Parámetros del Adquirente / Cliente (`<cac:AccountingCustomerParty>`)
Campos dinámicos que se capturan en la caja del supermercado.

### Escenario A: Cliente Identificado
* **`<cbc:CompanyID>`**: Número de identificación (Cédula o NIT). El atributo `schemeID` debe llevar el DV si es un NIT.
* **Tipo de Documento (`<cac:Party>/<cac:PartyTaxScheme>/<cbc:AdditionalAccountID>`)**:
    * `13` = Cédula de Ciudadanía.
    * `31` = NIT (Identificación tributaria).
    * `22` = Cédula de Extranjería.
* **`<cbc:RegistrationName>`**: Nombre completo o razón social del cliente.
* **`<cbc:ElectronicMail>`**: Correo electrónico del cliente. **Parámetro crítico:** Es la dirección a la que el Core le enviará el XML + PDF una vez la DIAN apruebe la factura.

### Escenario B: Consumidor Final (Anónimo)
Si el cliente de la caja no quiere dar sus datos, se deben enviar estos parámetros exactos fijos por ley:
* **`<cbc:CompanyID>`**: `222222222222` (Doce veces el número dos).
* **`schemeID` de la etiqueta**: No aplica o se omite.
* **Tipo de Documento**: `13` (Cédula de ciudadanía).
* **`<cbc:RegistrationName>`**: `CONSUMIDOR FINAL`.

---

## 4. Parámetros de Forma y Métodos de Pago (`<cac:PaymentMeans>`)

Parámetros que le informan a la DIAN cómo ingresó el dinero de la venta.

* **Forma de Pago (`<cbc:ID>`)**:
    * `1` = Contado (Efectivo, Tarjeta Débito/Crédito en la caja del supermercado).
    * `2` = Crédito (Ventas institucionales o convenios empresariales a 30/60 días).
* **Método de Pago (`<cbc:PaymentMeansCode>`)**: Códigos estandarizados por la DIAN.
    * `10` = Efectivo.
    * `48` = Tarjeta Crédito.
    * `49` = Tarjeta Débito.
    * `1` = Instrumento no definido (Uso común para pasarelas o bonos).
* **Fecha de Vencimiento (`<cbc:PaymentDueDate>`)**: Obligatorio si la forma de pago es Crédito (`2`). Indica cuándo debe pagar el cliente.

---

## 5. Parámetros de Líneas de Detalle / Productos (`<cac:InvoiceLine>`)

Este bloque se repite por cada artículo registrado en el tiquete de venta.

* **`<cbc:ID>`**: Consecutivo de la línea (1, 2, 3...).
* **`<cbc:InvoicedQuantity>`**: Cantidad del producto vendido (Admite decimales para productos pesados en Fruver o carnicería, ej: `1.50` Kilos). El atributo `unitCode` lleva la unidad de medida (Ej: `94` para unidades, `KGM` para kilogramos).
* **`<cbc:LineExtensionAmount>`**: Valor neto total de la línea. Es el resultado de: `Cantidad × Precio Unitario` (Antes de impuestos y descuentos).
* **`<cac:Item>/<cbc:Description>`**: Nombre comercial del producto (Ej: `Arroz Premium Diana 1kg`).
* **`<cac:Price>/<cbc:PriceAmount>`**: Precio unitario del artículo antes de impuestos.

### Sub-bloque de Impuestos por Producto (`<cac:TaxTotal>`)
Cada línea de producto debe especificar su propio impuesto:
* **`<cbc:TaxAmount>`**: El valor en dinero del impuesto para esa línea.
* **`<cbc:Percent>`**: El porcentaje del impuesto aplicado (Ej: `19.00`, `5.00` o `0.00` si es exento).
* **`<cac:TaxScheme>/<cbc:ID>`**: Código del tributo. `01` para IVA, `04` para Impuesto Nacional al Consumo (INC).