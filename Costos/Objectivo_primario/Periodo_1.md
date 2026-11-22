# Costos del Periodo 1: Implementación Interna (Uso Propio)
El objetivo en esta fase es mantener los costos al mínimo mientras se valida el Core con la operación de la empresa actual.

| Concepto | Tipo de Costo | Frecuencia | Costo Estimado (COP) | Descripción / Justificación |
| :--- | :--- | :--- | :--- | :--- |
| **Certificado Digital de Firma** | Operativo (OpEx) | Anual | \$350.000 - \$500.000 | Requerido para que el Core firme los XML de la empresa actual. Se compra a una entidad autorizada (GSE, AndesCD, Certicámara). |
| **Servicio de Correo Masivo (API)** | Operativo (OpEx) | Mensual (Variable) | \$20.000 - \$50.000 | Uso de Amazon SES o SendGrid para garantizar que las facturas no caigan en la bandeja de Spam de los clientes. (Aprox. \$400 COP por cada 1.000 correos). |
| **Certificado SSL/TLS Comercial** | Operativo (OpEx) | Anual | \$0 - \$150.000 | Para asegurar la comunicación HTTPS entre el Middleware (ICG) y el Core. Se puede usar *Let's Encrypt* (Gratis) o uno pago para mayor respaldo. |
| **Respaldo en la Nube (Backup)** | Operativo (OpEx) | Mensual | \$40.000 - \$80.000 | Almacenamiento híbrido básico (ej. AWS S3 o Azure Blob) para guardar una copia de seguridad externa de los XML emitidos. |
| **TOTAL ESTIMADO PERIODO 1** | | **Anualizado** | **\$800.000 - \$1'200.000** | **Costo de operación interna sumamente bajo y controlado.** |

---