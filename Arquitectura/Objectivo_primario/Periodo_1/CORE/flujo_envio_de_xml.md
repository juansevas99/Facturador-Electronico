---

## 2. Desglose Técnico Paso a Paso

### Fase 1: Estructuración y Firma del XML
* **Acción:** El motor del Core toma las variables transaccionales de la operación y ensambla un archivo de texto plano con estructura jerárquica XML bajo el estándar **UBL 2.1**.
* **Firma Criptográfica:** Inmediatamente después de construir el XML, el Core accede al certificado digital (`.pfx` / `.p12`) de la empresa emisor y aplica una firma digital de tipo **XAdES-BES** (XML Advanced Electronic Signatures) directamente en el nodo `<ext:UBLExtensions>`.
* **Resultado:** Un archivo en disco o memoria llamado temporalmente `documento.xml`, el cual ya cuenta con validez legal, CUFE/CUDE calculado e integridad matemática asegurada.

### Fase 2: Compresión del Archivo (.zip)
* **Acción:** El WebService de la DIAN rechaza archivos XML sueltos en sus métodos principales de timbrado masivo y unitario. El sistema debe tomar el archivo `documento.xml` de la fase anterior y comprimirlo utilizando el algoritmo estándar **DEFLATE** en un contenedor comprimido.
* **Resultado:** Un archivo binario comprimido con extensión `.zip` (Ej: `seftp990000001.zip`). Esto reduce el tamaño del payload de transmisión hasta en un 85%, optimizando el ancho de banda del Core y de la DIAN.

### Fase 3: Codificación en Base64
* **Acción:** Los protocolos de mensajería basados en texto (como XML y SOAP) no admiten la inclusión directa de caracteres binarios crudos sin corromper el mensaje HTTP. Por lo tanto, el Core lee el archivo binario `.zip` como un arreglo de bytes y lo transforma mediante el algoritmo de codificación **Base64**.
* **Resultado:** El archivo comprimido se convierte en una sola cadena de texto alfanumérico plano.
  * *Ejemplo conceptual:* Un archivo ZIP de 15KB se transforma en un string de texto continuo como: `UEsDBBQAAAAIAI6ptFYAAAAAAAAAAAAAAAALAAAAc2VmdHA5OT...`

### Fase 4: Inyección en el Sobre SOAP 1.2
* **Acción:** El string Base64 se convierte en el "payload" o carga útil de la petición. El Core construye un sobre SOAP 1.2, inyecta los encabezados de seguridad de transporte (**WS-Security**) y coloca la cadena Base64 dentro de la etiqueta correspondiente al método SOAP invocado.
* **Ubicación en el cuerpo (Body):**
  * Para el set de pruebas, se inyecta en el parámetro `<wcf:contentFile>` dentro de la función `<wcf:SendTestSetAsync>`.
  * Para producción normal síncrona, se inyecta en `<wcf:contentFile>` dentro de la función `<wcf:SendBillSync>`.

### Fase 5: Consumo HTTP POST y Recepción de Respuesta
* **Acción:** El Core abre una conexión de red persistente y realiza una petición de tipo **HTTP POST** apuntando al endpoint de la DIAN (para habilitación: `https://vpfe-hab.dian.gov.co/WcfDianCustomerServices.svc`).
* **Espera y Retorno (Síncrono):** El canal HTTP se mantiene abierto mientras los servidores de la DIAN desenvuelven la muñeca rusa (abren el sobre SOAP, decodifican el Base64, descomprimen el ZIP, validan la firma XAdES-BES del XML y evalúan las reglas tributarias).
* **Respuesta:** La DIAN responde por la misma conexión con un código de estado `HTTP 200 OK` y un sobre SOAP de respuesta que contiene el archivo **ApplicationResponse** en formato XML, indicando el éxito (Documento Validado) o el rechazo (Lista de errores técnicos).

---

## 3. Matriz de Transformación del Payload

Para asegurar la correcta programación de este flujo en las funciones del Core, los datos sufren las siguientes mutaciones de tipo de datos:

| Paso del Pipeline | Formato de Entrada | Proceso Aplicado | Formato de Salida | Propósito Técnico |
| :--- | :--- | :--- | :--- | :--- |
| **1. Instanciación** | Datos Crudos / Clases | Serialización + Firma X509 | Texto XML (UBL 2.1) | Cumplimiento de estructura fiscal. |
| **2. Empaquetado** | Texto XML | Compresión ZIP (ZipOutputStream) | Archivo Binario (.zip) | Reducción de peso de red obligatoria. |
| **3. Conversión** | Archivo Binario (.zip) | `Convert.ToBase64String()` | Cadena de Texto (String) | Compatibilidad con nodos SOAP de texto. |
| **4. Inyección** | Cadena de Texto | Encapsulamiento XML SOAP | Sobre SOAP 1.2 (Payload POST)| Protocolo de transporte exigido por DIAN. |
"""