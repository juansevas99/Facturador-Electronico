## 4. Uso de las Variables en el Flujo de Autenticación

Para que la comunicación no sea rechazada por fallas de autenticación, el Core API procesará estas variables en dos frentes específicos antes de disparar la petición HTTP POST:

### A. Autenticación a Nivel de Transporte (WS-Security)
Al consumir el endpoint `DIAN_ENDPOINT_URL`, la cabecera del sobre SOAP utiliza el certificado digital de la empresa para firmar el mensaje. El servidor de la DIAN intercepta esta firma, extrae el NIT del certificado y verifica en su base de datos interna si ese NIT tiene registrado el software `DIAN_SOFTWARE_ID` en estado `En proceso` o `Habilitado`. Si la relación no existe en la DIAN, el canal se cierra con un error de seguridad.

### B. Autenticación a Nivel de Aplicación (SigningIdentifier)
Dentro de cada XML enviado, el Core debe demostrar que conoce el PIN privado del software sin exponerlo en texto plano. Para ello, utiliza la siguiente fórmula de concatenación matemática obligatoria:

```text
Cadena_Seguridad = DIAN_SOFTWARE_ID + DIAN_SOFTWARE_PIN + Numero_Documento
Algoritmo_Aplicado = SHA-384(Cadena_Seguridad)