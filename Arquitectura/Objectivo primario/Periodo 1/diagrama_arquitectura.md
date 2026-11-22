# Diagrama de Arquitectura (Edge-to-Cloud)

Este diagrama representa el flujo de datos y la distribución de componentes físicos y lógicos en la nueva arquitectura propuesta.

```mermaid
graph TD
    subgraph Sede["Sede / Sucursal (Ej. Sede Norte)"]
        subgraph Cajas["Puntos de Venta (Thin Clients)"]
            C1[Caja Registradora 1<br/>NUMSERIE: NRT1]
            C2[Caja Registradora 2<br/>NUMSERIE: NRT2]
        end

        SW((Switch Gigabit))

        subgraph ServidorLocal["Servidor Periférico de Tienda"]
            DB_ICG[(BD ICGFRONT<br/>SQL Server Express)]
            
            subgraph MiddlewareLocal["Agente Middleware"]
                Extractor[Extractor / Generador JSON]
                Cola[(Cola Store-and-Forward<br/>SQLite)]
            end
        end
    end

    subgraph Nube["Nube / Centro de Datos (Core Fiscal)"]
        API[API Core Fiscal<br/>Python]
        Liquidador[Liquidador Fiscal y Generador XML]
        DB_Core[(BD CoreFiscal_DB<br/>Trazabilidad y Auditoría)]
    end

    DIAN((Plataforma DIAN))

    %% Conexiones Red Local
    C1 ===|Red LAN| SW
    C2 ===|Red LAN| SW
    SW ===|Red LAN| DB_ICG

    %% Flujo Middleware
    DB_ICG -->|1. Lee Facturas sin CUFE| Extractor
    Extractor -->|2. Encola si no hay red| Cola
    Cola -->|3. Retoma envío| Extractor

    %% Conexiones WAN / Internet
    Extractor ===|4. Envía JSON vía HTTPS| API
    API -->|5. Procesa JSON| Liquidador
    Liquidador -->|6. Guarda histórico| DB_Core
    Liquidador ===|7. Transmite XML firmado| DIAN
    DIAN ===|8. Retorna Respuesta y CUFE| Liquidador
    API ===|9. Devuelve CUFE al Middleware| Extractor
    Extractor -->|10. Write-Back Update| DB_ICG
    
    classDef caja fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef server fill:#e1f5fe,stroke:#03a9f4,stroke-width:2px;
    classDef middleware fill:#fff3e0,stroke:#ff9800,stroke-width:2px;
    classDef nube fill:#f3e5f5,stroke:#9c27b0,stroke-width:2px;
    classDef dian fill:#e8f5e9,stroke:#4caf50,stroke-width:2px;

    class C1,C2 caja;
    class ServidorLocal server;
    class Extractor,Cola middleware;
    class API,Liquidador,DB_Core nube;
    class DIAN dian;
```

### Descripción del Flujo
1.  **Facturación Offline:** Las cajas (`C1`, `C2`) operan sin necesidad de internet. Guardan sus ventas directamente en `BD ICGFRONT` a través de la red LAN local.
2.  **Extracción Inyectada:** El `Middleware Local` lee continuamente la `BD ICGFRONT` buscando facturas que aún no tienen CUFE.
3.  **Contingencia Automática:** Si hay internet, el Middleware envía el `JSON` a la Nube. Si no hay internet, guarda el `JSON` en su `Cola SQLite` de forma inmutable, esperando recuperar conexión.
4.  **Cerebro Centralizado:** La `Nube (Core Fiscal)` recibe la petición, arma el XML, lo firma, se comunica con la `DIAN` y almacena la trazabilidad definitiva en su propia `BD CoreFiscal_DB`.
5.  **Cierre del Ciclo:** La Nube devuelve la respuesta al Middleware, y este hace el `UPDATE` final (Write-back) en la base de datos de ICG para que el cajero vea su factura autorizada.
