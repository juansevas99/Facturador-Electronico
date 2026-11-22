# Especificación Técnica: Variables de Autenticación y Conectividad DIAN

Este documento consolida de forma aislada los parámetros, credenciales y variables técnicas obligatorias para establecer una conexión segura, autenticada y autorizada con el WebService de la DIAN durante la fase de habilitación.

---

## 1. Variables de Identificación del Software (Credenciales)

Estas variables actúan como el "usuario y contraseña" de la aplicación ante la infraestructura del estado. Deben ser almacenadas de forma segura en el servidor de aplicaciones (Variables de Entorno / Environment Variables).

| Variable en Código | Valor de Configuración | Descripción Técnica |
| :--- | :--- | :--- |
| `DIAN_SOFTWARE_ID` | `ed983188-0fd9-4bcf-9f80-5f4588f81faf` | Identificador único (GUID) asignado al software **IO Solutions** en el portal de la DIAN. |
| `DIAN_SOFTWARE_PIN` | `12345` | Código numérico de seguridad asociado al Software ID para el cálculo de firmas locales. |
| `DIAN_TECHNICAL_KEY` | `fc8eac422eba16e22ffd8c6f94b3f40a6e38162c` | Llave técnica criptográfica utilizada exclusivamente como "sal" (salt) para el cálculo del hash del CUFE/CUDE. |
| `DIAN_MODE_OPERATION`| `Software propio` | Régimen de operación técnica. Indica que la empresa dueña del NIT es la misma desarrolladora. |

---

## 2. Variables de Control de Resolución y Rangos de Prueba

Parámetros mandatorios que el Core debe inyectar dinámicamente en la cabecera del XML comercial (`<cac:InvoiceControl>`) para que la DIAN valide la legalidad del consecutivo.

* **Prefijo Autorizado (`DIAN_PREFIX`):** `SETP`
* **Número de Resolución (`DIAN_RESOLUTION_NUM`):** `18760000001`
* **Fecha de Resolución (`DIAN_RESOLUTION_DATE`):** `01-01-0001`
* **Rango Inicial (`DIAN_RANGE_FROM`):** `990000000`
* **Rango Final (`DIAN_RANGE_TO`):** `995000000`
* **Vigencia Inicial (`DIAN_DATE_FROM`):** `19-01-2019`
* **Vigencia Final (`DIAN_DATE_TO`):** `19-01-2030`

---

## 3. Parámetros de Red y Estado del Arte (Conectividad SOAP)

Variables de enrutamiento que el cliente HTTP del Core utiliza para dirigir los paquetes de red y mapear el estado del proyecto en la base de datos de trazabilidad.

* **URL del WebService (WSDL) (`DIAN_ENDPOINT_URL`):** `https://vpfe-hab.dian.gov.co/WcfDianCustomerServices.svc?wsdl`
* **Fecha de Registro del Software:** `11-06-2026`
* **Estado Actual en Plataforma:** `En proceso`

---

