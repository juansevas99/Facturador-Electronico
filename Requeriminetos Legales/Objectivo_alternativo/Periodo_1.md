## 4.3.1. Periodo 1: Implementación Interna (Conector Monolítico Propio)
En esta fase, la empresa utiliza el conector desarrollado internamente para alimentar la API del PT contratado para su propia facturación.

### A. Requerimientos Tributarios y de Mapeo
* **Asociación en el Portal DIAN:** La empresa actual debe ingresar a su portal MUISCA y asociar como modo de operación al **Proveedor Tecnológico contratado** (y no como software propio). 
* **Set de Pruebas Delegado:** El proceso de habilitación ante la DIAN (pasar el set de pruebas) se realiza a través de la plataforma del PT. El Core de ustedes solo debe garantizar que los datos enviados por API cumplan con las reglas de validación previas que el PT exige (las cuales reflejan el Anexo Técnico de la DIAN).
* **Consumo de Rangos desde el PT:** En lugar de consultar directamente a la DIAN, el Core debe sincronizar los prefijos y rangos de facturación autorizados consumiendo los servicios web del PT, quien previamente los habrá importado desde el MUISCA.
* **Lógica de Contingencia del PT:** Si la API del PT responde con un error de indisponibilidad, el software integrador debe estar en la capacidad de almacenar localmente los documentos en una cola de espera y reintentar el envío automáticamente una vez el servicio del PT se restablezca.

### B. Requerimientos Jurídicos y Legales
* **Contrato de Mandato Fiscal (Estatuto Tributario):** La empresa debe firmar un contrato de mandato con el PT elegido. Bajo esta figura legal, la empresa autoriza al PT a firmar digitalmente los XML y a transmitirlos a la DIAN en su nombre.
* **Custodia Legal Compartida:** Aunque el PT tiene la obligación legal de conservar los XML por 5 años en sus servidores, jurídicamente la empresa debe mantener un respaldo local (en su base de datos de trazabilidad) para responder de forma ágil ante auditorías internas o requerimientos ordinarios de la DIAN.
* **Cumplimiento de Habeas Data (Ley 1581 de 2012):** Al transmitir los datos de sus adquirentes a los servidores de un tercero (el PT), se debe verificar que en los términos y condiciones de la empresa se especifique que los datos personales de facturación serán compartidos con proveedores de servicios autorizados para fines estrictamente fiscales.