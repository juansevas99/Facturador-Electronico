# Presupuesto de Infraestructura: Servidor Periférico por Sede (Edge Server)

Este documento detalla la inversión requerida en hardware, software y red para implementar la arquitectura de **Servidor Centralizado por Tienda** en las sucursales de Supermercados Ramírez Hermanos.

Esta arquitectura reemplaza el modelo de base de datos individual por caja, centralizando la operación en un solo equipo robusto por sede, el cual alojará la base de datos `ICGFRONT` y el **Middleware Local (Agente Extractor)** de facturación electrónica.

---

## 1. Especificaciones y Costos Unitarios (Por Sede)

A continuación, el desglose de los componentes necesarios para equipar **una sola sede** (diseñado para soportar la carga operativa de hasta 5 cajas registradoras simultáneas).

| Categoría | Componente Sugerido | Justificación Técnica | Costo Estimado (USD) | Costo Estimado (COP) |
| :--- | :--- | :--- | :--- | :--- |
| **Hardware Core** | Torre PC Corporativa (Intel Core i5 10ª/12ª Gen, 16GB RAM, 512GB SSD NVMe) | La RAM de 16GB es indispensable para el rendimiento de SQL Server. El SSD NVMe garantiza la velocidad de escritura de los tiquetes. El procesador i5 maneja sin esfuerzo las 20 transacciones por minuto en hora pico y la ejecución del Middleware en segundo plano. | $450 | $1,800,000 |
| **Software OS** | Licencia Microsoft Windows 10 Pro / 11 Pro (OEM) | Requerido para integrarse a la red empresarial (Active Directory), permitir administración por Escritorio Remoto (RDP), forzar políticas de seguridad (GPOs) e implementar encriptación de disco (BitLocker). | $150 | $600,000 |
| **Software BD** | Microsoft SQL Server Express Edition 2019/2022 | Versión gratuita. Soporta hasta 10GB de base de datos, lo cual es suficiente ya que el servidor periférico sincroniza periódicamente con el central (`RAMSAS`) y no retiene históricos de décadas. | $0 | $0 |
| **Software Cola** | SQLite (Integrado en el Middleware) | Motor de base de datos embebido para gestionar la cola de mensajes (Store-and-Forward) en caso de caída de internet. | $0 | $0 |
| **Red** | Switch Gigabit 8 puertos (Ej. TP-Link Omada SG2008) | Estandariza la conectividad LAN de la tienda bajo el ecosistema Omada existente de la empresa, permitiendo gestión centralizada desde Bogotá. | $60 | $250,000 |
| **Contingencia** | UPS 750VA / 1000VA (Ej. APC) | Obligatorio. Protege al servidor y al switch contra apagones, evitando la corrupción de la base de datos de ventas en vivo. | $100 | $400,000 |
| **Cableado** | Patch Cords Cat 6 (Varios) | Conexión cableada de alta velocidad entre el Switch, el Servidor y las Cajas. | $30 | $120,000 |
| **Total por Sede** | | | **$790 USD** | **$3,170,000 COP** |

*(Nota: Los precios son estimaciones de mercado a la fecha y pueden variar según proveedor y volumen de compra).*

---

## 2. Inversión Global (Rollout 13 Sedes)

Para el despliegue a nivel corporativo en las 13 sedes físicas de Ramírez Hermanos, la inversión consolidada (CAPEX) en infraestructura sería la siguiente:

> [!IMPORTANT]
> **Inversión Total Estimada:** **$10,270 USD** (Aprox. **$41,210,000 COP**).

### Justificación del Retorno de Inversión (ROI) y TCO
Aunque representa un desembolso inicial, este modelo reduce drásticamente el Costo Total de Propiedad (TCO) frente al modelo anterior (Base de datos instalada en cada caja):

1.  **Reducción de Costos de Hardware POS:** Al no requerir SQL Server en las cajas físicas, las futuras renovaciones de las 65 terminales POS se podrán hacer con hardware "Thin Client" o PCs de gama baja (Celeron/Pentium, 4GB RAM), ahorrando millones en cada ciclo de renovación.
2.  **Mitigación de Pérdidas de Venta:** Las caídas de base de datos por caja se reducen a cero. La contingencia se concentra y protege con UPS y BitLocker en un solo equipo por tienda.
3.  **Ahorro Operativo (Soporte de TI):** El equipo de infraestructura ya no necesita desplazarse a las sedes para resolver problemas de SQL locales; el 99% del mantenimiento se puede realizar vía Escritorio Remoto (RDP) al único servidor de la sede.
