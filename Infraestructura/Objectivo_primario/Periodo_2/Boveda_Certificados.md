# Gestión Criptográfica y Bóveda de Certificados (Periodo 2)

El mayor riesgo legal y técnico de convertir la plataforma en un SaaS es el manejo de las firmas digitales (Certificados `.pfx`). Como proveedores tecnológicos, tendremos la responsabilidad de custodiar las firmas de cientos de empresas y utilizarlas en milisegundos para firmar sus XMLs, asegurando que un certificado jamás se cruce con el de otra empresa.

---

## 1. La Bóveda de Hardware: Azure Key Vault

Para asegurar la máxima protección de las claves privadas, los archivos `.pfx` nunca se guardarán como archivos físicos en el disco duro de los contenedores del Core API, ni como campos binarios en la Base de Datos SQL.

Se utilizará **Azure Key Vault**:
* **Aislamiento Criptográfico:** Key Vault usa Hardware Security Modules (HSMs) validados por FIPS 140-2, lo que garantiza que las claves privadas no puedan ser exportadas ni leídas en texto plano por nadie (ni siquiera por los desarrolladores).
* **Referencia Cruzada:** En nuestra base de datos (Azure SQL), la tabla de clientes solo guardará la "URL" o Identificador del secreto dentro del Key Vault (ej. `https://myvault.vault.azure.net/secrets/cert-tenant-1234`).
* **Inyección en Tiempo de Ejecución:** Cuando el contenedor del Core API necesita firmar un XML, se autenticará ante el Key Vault usando su propia Identidad Administrada (Managed Identity) de Azure, extraerá el certificado en memoria RAM por unos milisegundos, firmará el documento (Librería de XAdES) y lo destruirá de la memoria.

---

## 2. Segregación de Roles (RBAC)

El acceso a la bóveda será restrictivo:
* Solo el servicio productivo (Core API) tendrá el permiso `Secret User` para consumir certificados.
* Los desarrolladores tendrán el permiso de acceso bloqueado en producción.
* Esto protege a la empresa operadora de la plataforma contra el riesgo interno de fuga de certificados (Riesgo 4.3).
