# Persistencia y Almacenamiento Multi-Tenant (Periodo 2)

El salto a la nube exige replantear cómo se almacena la información. Ya no estamos guardando facturas de una sola empresa, sino de N clientes.

---

## 1. Base de Datos Relacional: Azure SQL Database

Mantendremos el motor SQL Server que el equipo domina, pero bajo el modelo PaaS (Platform as a Service) de Azure SQL Database.

### Aislamiento Multi-Tenant (Modelo: Pool Compartido con `tenant_id`)
De las tres opciones arquitectónicas posibles (Silo, Esquema, o Pool Compartido), se adoptará el modelo de **Pool Compartido**.

* **Estructura:** Todos los clientes compartirán las mismas tablas físicas (ej. `Facturas`, `Clientes`).
* **Segregación:** Todas las tablas tendrán una columna obligatoria `tenant_id` vinculada al cliente externo.
* **Seguridad Avanzada (Row-Level Security):** Para mitigar el riesgo de que el Cliente A vea los datos del Cliente B por un error de código (Bug), se implementará **Seguridad a Nivel de Fila (RLS)** directamente en el motor de SQL Server. Esto garantiza matemáticamente que el ORM o la API solo puedan acceder a las filas donde el `tenant_id` coincida con el token de sesión actual, brindando aislamiento a nivel de base de datos sin el costo enorme de mantener cientos de bases de datos individuales.

---

## 2. Almacenamiento de Objetos: Azure Blob Storage (S3)

La DIAN exige conservar los XML y PDF de las facturas por un periodo de **5 años**. Guardar archivos binarios dentro de una base de datos SQL es extremadamente costoso en la nube.

* **El Cambio:** La base de datos de trazabilidad (Azure SQL) solo guardará los metadatos (Fechas, CUFE, Estado, Totales, `tenant_id`).
* **Almacenamiento Físico:** El texto real del JSON (Petición), el XML (Firmado) y el PDF (Representación Gráfica) se subirán a contenedores de **Azure Blob Storage**.
* **Retención de Datos (Lifecycle Policies):** Se configurarán políticas de ciclo de vida automáticas. Los archivos que superen los 2 años se moverán automáticamente al nivel de almacenamiento de archivo ("Archive Tier", almacenamiento "frío") que cuesta una fracción de centavo por gigabyte, reduciendo drásticamente los costos de retención a largo plazo.
