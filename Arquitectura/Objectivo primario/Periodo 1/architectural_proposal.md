# Propuesta Arquitectónica: Modernización POS y Facturación Electrónica

A partir del análisis de la infraestructura de **Supermercados Ramírez Hermanos** y el sistema ICG actual, hemos diseñado una arquitectura moderna, distribuida (Edge-to-Cloud) y altamente desacoplada. Esta propuesta no solo resuelve la integración con la DIAN, sino que moderniza toda la operación en los puntos de venta.

A continuación, el resumen de los pilares arquitectónicos y sus beneficios:

## 1. Topología: Consolidación por Sede (Edge Computing)
**Situación anterior:** Cada caja registradora tenía su propia base de datos SQL Server instalada físicamente, sincronizando individualmente.
**Nueva Arquitectura:** 
*   Las cajas físicas se convierten en "Thin Clients" (terminales ligeras) sin bases de datos locales.
*   Se instala **una sola base de datos (`ICGFRONT`) en el Servidor Periférico de la Tienda (Sede)**. Todas las cajas de esa sede se conectan a este servidor local vía red LAN Gigabit. La diferenciación de cajas se mantiene lógicamente a través del prefijo (`NUMSERIE`).

> [!TIP]
> **Beneficio (Costos y Mantenimiento):** Reduce drásticamente el TCO (Costo Total de Propiedad). Permite usar hardware mucho más económico en las cajas y centraliza el mantenimiento y los backups en un solo equipo por tienda en lugar de decenas.

## 2. El Agente Local (Middleware Híbrido)
**Situación anterior:** Uso de la base de datos monolítica `FLX_BD` que obligaba a aplanar datos pesados, creando acoplamiento rígido con el software antiguo de ICG.
**Nueva Arquitectura:**
*   Se descarta `FLX_BD`. 
*   Se despliega un **Middleware Local (Agente)** ligero en el Servidor de la Tienda. Este agente hace lecturas directas a la tabla nativa de ventas de ICG, extrae los datos puros y los empaqueta en un formato universal (`JSON`).

> [!IMPORTANT]
> **Beneficio (Tolerancia a Fallos y Red):** Implementa el patrón **Store-and-Forward**. Si el túnel VPN a internet se cae, el Middleware encola localmente los JSON. Las cajas siguen facturando sin interrupción. Al regresar el internet, se transmiten en ráfaga.

## 3. El Core Fiscal Desacoplado (Nube o Servidor Central)
**Situación anterior:** La lógica fiscal y la generación de archivos para la DIAN estaban atadas a la tecnología y base de datos del ERP.
**Nueva Arquitectura:**
*   El **Core Fiscal** (tu desarrollo actual en Python) vive en la Nube o en el servidor central aislado. 
*   Expone un API que recibe los JSON enviados por los Middlewares locales. Ejecuta el Motor de Reglas (`LiquidadorFiscal`), genera el XML UBL 2.1, lo firma y lo transmite a la DIAN.

> [!TIP]
> **Beneficio (Flexibilidad y Multi-Fuente):** Si Ramírez Hermanos decide cambiar ICG por SAP u Odoo en 2 años, el Core Fiscal no se toca. Solo se reemplaza el Agente Local para que lea de la nueva base de datos. El Core también podrá recibir facturación de una futura tienda eCommerce.

## 4. Base de Datos de Trazabilidad Exclusiva (`CoreFiscal_DB`)
**Nueva Arquitectura:** 
El Core Fiscal es dueño de su propia base de datos independiente. Allí guarda celosamente los JSON originales, los XML firmados, los PDFs, las respuestas crudas de la DIAN y todo el historial de reintentos.
Al ERP (ICG) **solo se le hace un write-back mínimo (UPDATE)** con 4 campos operativos: CUFE, QR, Estado y Fecha de Validación.

> [!NOTE]
> **Beneficio (Integridad y Auditoría):** Garantiza que la historia fiscal de la empresa viva para siempre, inmune a las corrupciones de las bases de datos de las tiendas. Además, permite construir Dashboards administrativos (Big Data / BI) súper rápidos sin competir por recursos con la operación de ventas en vivo.

---

### Conclusión Estratégica
Pasamos de un parche temporal de bases de datos a diseñar un ecosistema **Enterprise-Grade**. La seguridad se incrementa al reducir los puntos de falla, la integridad de los datos se garantiza ante cortes de red, y la empresa queda preparada tecnológicamente para integraciones futuras con cualquier plataforma de software.
