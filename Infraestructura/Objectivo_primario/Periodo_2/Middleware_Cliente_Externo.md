# Middleware de Cliente Externo: Modelo SaaS (Periodo 2)

En el Periodo 1, al tener control absoluto sobre la red corporativa de Ramírez, adoptamos un modelo de extracción "Pull" centralizado mediante túneles VPN MESH (Tailscale). En el Periodo 2, este modelo es inviable, ya que no tendremos acceso VPN a la infraestructura de supermercados externos.

Debemos cambiar la naturaleza del Middleware para convertirlo en un producto distribuible.

---

## 1. Cambio de Paradigma: Del Pull al Push

El Middleware se transformará en un **Software Cliente (.msi / .exe)** que el cliente externo descargará de nuestra plataforma e instalará en su propio servidor donde reside su base de datos ICG local.

* **Responsabilidad del Cliente:** El cliente ejecuta el instalador. Aparecerá un *Wizard* (Asistente Gráfico) donde deberá ingresar:
  1. Las credenciales de su SQL Server local (Usuario, Contraseña, Nombre del Servidor).
  2. Su **API Key / Token JWT** único, proporcionado por nuestra plataforma en la nube al momento de comprar el servicio.
* **Modelo Push:** El servicio de Windows instalado en la máquina del cliente externo hará Polling constante sobre su **propia base de datos local** (`ALBVENTACAB`). Cuando encuentre una venta nueva, armará el JSON crudo y realizará un `HTTP POST` hacia nuestra API Gateway en Azure (`https://api.tufactura.com/v1/invoices`).

---

## 2. Seguridad en Tránsito (Cifrado asimétrico)

* **Comunicación Segura:** Todas las peticiones HTTP que salgan del supermercado externo hacia nuestra nube viajarán bajo el protocolo TLS 1.3 (HTTPS).
* **Autenticación (API Keys):** El payload JSON incluirá en las cabeceras (`Headers`) el Bearer Token del cliente.
* Nuestro API Gateway recibirá la petición, desencriptará el JWT, validará la firma digital del token, identificará el `tenant_id` y lo inyectará en la petición antes de enviarla a los contenedores internos del Core API. Esto asegura que el cliente jamás pueda escribir en las facturas de otro `tenant_id`.

---

## 3. Manejo Local de Colas (Contingencia del Cliente)

La resiliencia sigue viva. Si el supermercado externo se queda sin internet (una situación común), el Middleware instalado localmente simplemente acumulará los JSON en una base de datos SQLite embebida en su equipo. 

Cuando el servicio de internet del cliente externo retorne, el Middleware desencolará automáticamente los documentos y los disparará masivamente a nuestra nube, garantizando cero pérdida de transacciones.
