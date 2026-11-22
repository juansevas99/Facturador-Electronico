## 2.1. Topología y Relación de Nodos (Modelo de Red Zero-Trust)

```mermaid
graph TB
    %% Definición de Estilos Criptográficos y de Red
    classDef vlanCajas fill:#fff7ed,stroke:#ea580c,stroke-width:2px;
    classDef serverApp fill:#f0fdf4,stroke:#16a34a,stroke-width:2px;
    classDef serverDb fill:#eff6ff,stroke:#2563eb,stroke-width:2px;
    classDef internet fill:#fff1f2,stroke:#e11d48,stroke-width:2px;

    %% SEGMENTO 1: CAJAS EN TIENDAS (AISLADAS)
    subgraph PERIMETRO_TIENDAS ["Zona Segura: Puntos de Venta (VLAN 20)"]
        Cajas[Terminales FrontCS / FrontRetail <br> 13 Sedes Físicas]:::vlanCajas
    end

    %% SEGMENTO 2: SERVIDOR DE APLICACIONES (HOST INTERMEDIO)
    subgraph SVR_APPLICACIONES ["Servidor: SVRPREMIUMAPP (PowerEdge R730) [tag:server-app]"]
        MW[Middleware / Extractor ICG <br> Servicio Windows de Fondo]:::serverApp
        
        subgraph HYPER_V ["Capa de Virtualización Aislada"]
            CoreAPI[VM Dedicada: Core API Fiscal <br> Runtime .NET 8 / Node.js]:::serverApp
        end
        
        Cajas -->|1. Sincronización Local / ICGRemote| MW
        MW -->|3. Payload de Transacción JSON <br> Puerto Interno 8080/443| CoreAPI
    end

    %% SEGMENTO 3: SERVIDOR DE BASE DE DATOS (EL CORAZÓN)
    subgraph SVR_BASE_DATOS ["Servidor: srvbd--premium (PowerEdge R740) [tag:server-db]"]
        SQL_Engine[(Microsoft SQL Server 2019)]:::serverDb
        
        subgraph BD_OPERATIVA ["Ecosistema ERP ICG"]
            RAMSAS[(BD RAMSAS <br> Tablas: FACTURASVENTA / ALBVENTACAB)]:::serverDb
            FLX_BD[(BD FLX_BD <br> Espejo Compatibilidad ERP)]:::serverDb
        end
        
        subgraph BD_NUEVA ["Persistencia Propia"]
            TRACE_DB[(BD IO_SOLUTIONS_TRACE <br> Tablas: Trazabilidad y Logs)]:::serverDb
        end
    end

    %% INTERCONEXIONES TAILSCALE (VPN MESH WIREGUARD)
    MW -->|2. Polling de Lectura de Ventas <br> Puerto Seguro SQL 1433| RAMSAS
    CoreAPI -->|4. Escritura de Trazabilidad y XML <br> Puerto Seguro SQL 1433| TRACE_DB
    CoreAPI -->|5. Réplica de Estado Contable <br> Compatibilidad Back-Office| FLX_BD

    %% SEGMENTO 4: RED EXTERNA
    subgraph ENTIDADES_EXTERNAS ["Zonas WAN Externas"]
        DIAN[WebService SOAP DIAN <br> vpfe-hab.dian.gov.co]:::internet
        Mail[Servicio SMTP Correo Transaccional]:::internet
    end

    CoreAPI -->|6. Envío XML ZIP Base64 <br> HTTPS Puerto 443| DIAN
    CoreAPI -->|7. Notificación Documento Validado| Mail




### 3. Matriz de Interacción y Flujo Técnico entre Nodos

Para guiar al equipo de desarrollo en la programación de los sockets y cadenas de conexión, las interacciones se consolidan bajo las siguientes reglas fijas de red:

1. **De Cajas a SVRPREMIUMAPP (Tráfico Local - VLAN 20):** Las cajas facturan de forma autónoma. El software *FrontCS* vuelca los datos a través del canal tradicional de `ICGRemote` hacia el servidor de aplicaciones utilizando la red cableada de la tienda. **Las cajas nunca tocan la base de datos directamente ni conocen el nuevo Core API.**
2. **Del Middleware a la Base de Datos (Túnel Mesh Tailscale):** El Middleware, instalado en la raíz del servidor de aplicaciones, levanta un hilo en segundo plano que consulta la tabla `RAMSAS.dbo.ALBVENTACAB` en el servidor de Base de Datos. Este tráfico viaja exclusivamente cifrado por la IP `100.x.x.x` de WireGuard, superando el firewall local gracias al tag de autorización `tag:server-app -> tag:server-db`.
3. **Del Middleware al Core API (Acoplamiento de Memoria/Interno):** Tras mapear los datos del SQL, el Middleware realiza una llamada interna (*Localhost POST*) hacia la Máquina Virtual que aloja el Core API en Hyper-V. Le entrega un JSON plano listo para procesar.
4. **Del Core API a la DIAN y Trazabilidad (Salida y Cierre):** La VM del Core procesa, firma criptográficamente el archivo en memoria, comprime, codifica en Base64 y dispara el paquete hacia la DIAN por HTTPS. Al recibir el *ApplicationResponse*, abre dos conexiones de escritura hacia el R740 por el puerto 1433 de la VPN: una para salvar el XML legal en la nueva base `IO_SOLUTIONS_TRACE` y otra para actualizar el estado del back-office en la tabla clásica de `FLX_BD`.