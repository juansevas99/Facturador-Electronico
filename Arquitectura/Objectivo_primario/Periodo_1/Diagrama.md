### Diagrama de Arquitectura de Solución - Periodo 1 (Uso Interno)

```mermaid
graph TD
    %% Estilos de los nodos
    classDef supermercado fill:#f8fafc,stroke:#64748b,stroke-width:2px;
    classDef coreInterno fill:#f0fdf4,stroke:#16a34a,stroke-width:2px;
    classDef estado fill:#fef2f2,stroke:#dc2626,stroke-width:2px;

    %% ENTORNO SUPERMERCADO
    subgraph SUCURSALES ["Entorno Supermercado (Sedes + Central)"]
        Cajas[Terminales POS / Cajas]:::supermercado -->|Ventas locales| ICG[(ERP ICG <br> SQL Server Central)]:::supermercado
        ICG -->|1. Polling de Ventas / Notas| MW[Add-on / Middleware <br> Servicio Windows]:::supermercado
    end

    %% ENTORNO CORE FISCAL INTERNO
    subgraph CORE_PILOTO ["Nuevo Core Fiscal (Single-Tenant)"]
        API[Core API <br> Motor de Reglas y Firma]:::coreInterno
        DB[(DB Trazabilidad <br> Logs e Historial)]:::coreInterno
        Vis[Visualizador Web <br> Dashboard Contable]:::coreInterno
        IMAP[Extractor IMAP <br> Recepción Compras]:::coreInterno

        MW -->|2. Envío JSON HTTPS| API
        API -->|3. Almacena Logs y XML| DB
        Vis -->|Consulta Estados y Reenvíos| DB
        IMAP -->|Mapea XML de Proveedores| API
    end

    %% ENTIDADES EXTERNAS
    subgraph EXTERNOS ["Entidades Externas"]
        DIAN[Web Services DIAN <br> Validación SOAP]:::estado
        Mail[Servicio Correo <br> Amazon SES / SendGrid]:::estado
        Prov[Bandeja Correo <br> Proveedores]:::estado

        API -->|4. Envío XML Firmado XAdES-BES| DIAN
        DIAN -->|5. Retorna CUFE / CUDE| API
        API -->|6. Envío Correo con Adjuntos| Mail
        Prov -->|Lectura Automática| IMAP
    end

    %% Flujos Finales de Notificación
    Mail -->|XML + Representación Gráfica| Cliente[Cliente / Adquirente Final]