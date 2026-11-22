# Especificaciones Técnicas: Base de Datos de Trazabilidad (Periodo 1)

Este documento define el mecanismo de persistencia y registro histórico de las transacciones procesadas por el Core API, diseñado para mantener una pista de auditoría inmutable de la facturación electrónica.

---

## 1. Motor de Base de Datos y Alojamiento

La base de datos de trazabilidad no compartirá recursos con el motor transaccional de ICG (SQL Server) para evitar la degradación del rendimiento de las ventas en tienda.

* **Servidor Host:** Se desplegará en el nuevo servidor central dedicado **`SRV-CORE-01`**.
* **Motor Recomendado:** PostgreSQL 15+ o SQLite (en caso de buscar portabilidad extrema).
* **Volumen de Almacenamiento:** Unidad dedicada cifrada con BitLocker, con respaldos automáticos diarios.

---

## 2. Propósito y Alcance

* **Auditoría DIAN:** Almacenar el Request (JSON), el Response (XML firmado) y el código `TrackID`/`CUFE` devuelto por la DIAN para cada factura.
* **Manejo de Estados:** Controlar si un documento está en estado `EN_COLA`, `PROCESANDO`, `APROBADO_DIAN`, `RECHAZADO_DIAN` o `CON_ERRORES`.
* **Reportería:** Servir como fuente de datos para dashboards futuros que monitoreen la salud del sistema fiscal de Ramírez sin tocar la base de datos de ICG.