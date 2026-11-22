# Especificaciones Técnicas: Middleware de Extracción ICG (Periodo 1)

Este documento detalla los requerimientos arquitectónicos del **Middleware / Add-on**, el cual operará bajo un modelo centralizado de "Polling" o extracción remota (Pull).

---

## 1. Entorno de Despliegue Centralizado (Pruebas y Producción)

El Middleware se diseñará como un servicio centralizado que extrae información de las sucursales, eliminando la necesidad de instalar el software del facturador en cada caja. Es fundamental destacar que su ubicación será permanente.

* **Host de Despliegue (Permanente):** Se instalará **exclusivamente en la Máquina Virtual 1 (VM1)** aprovisionada sobre el nuevo servidor físico HP de alto rendimiento. 
* **Fases del Proyecto:**
  * **Fase de Pruebas:** Operará dentro de la VM1 leyendo datos de la réplica local aislada de la base de datos de ICG Manager.
  * **Fase de Producción (Go-Live):** El Middleware **permanecerá en la misma VM1 del servidor nuevo**. Únicamente cambiará su cadena de conexión para extraer la información directamente desde los nodos reales de producción, ya sea localmente o vía VPN.
* **Tipo de Aplicación:** Servicio de Windows nativo ejecutado en segundo plano.
* **Modo de Inicio:** Automático (*Automatic Delayed Start*), asegurando que el servicio se levante automáticamente si el servidor central se reinicia.

---

## 2. Estrategias de Extracción de Datos (Arquitecturas Candidatas)

Actualmente existe una infraestructura cliente-servidor (donde las cajas son clientes y se conectan por RDP al servidor de base de datos principal, sincronizando datos periódicamente y subiendo cada venta). Dependiendo de la evolución de la red, el Middleware en Producción podrá operar bajo dos posibles escenarios:

### Primera Posibilidad: Arquitectura Centralizada (Recomendada inicial)
Se mantiene la arquitectura actual de ICG. 
* **Flujo:** Las cajas siguen sincronizando y enviando sus ventas a la base de datos del servidor principal en tiempo real (o casi real).
* **Mecanismo:** El Middleware, alojado en la VM1, apuntará **únicamente** a esta base de datos central. Desde allí leerá todas las ventas de todas las sedes y consultará al CORE (VM2) para el envío de los Documentos Electrónicos.
* **Ventaja:** Menor complejidad de red; un solo punto de lectura y fácil mantenimiento.

### Segunda Posibilidad: Arquitectura Distribuida (Servidores por Sede / Edge)
Se modificaría la topología actual para añadir independencia física por tienda.
* **Flujo:** Se instalan mini-servidores (Edge) físicos en cada una de las 13 sedes. Las cajas de esa sede apuntarán exclusivamente a su servidor local.
* **Mecanismo:** El Middleware central (desde la VM1) iterará sobre las 13 direcciones IP de estos mini-servidores a través de VPNs (SD-WAN) y extraerá los datos localmente de cada sucursal. Alternativamente, se podría instalar una instancia ligera del Middleware en cada sede que empuje (Push) la información al CORE.
* **Ventaja:** Máxima contingencia. Si se cae el internet central, las tiendas siguen operando con su servidor local sin interrupciones.

## 3. Contingencia y Resiliencia en Sedes (Mini-Servidores)

El diseño descentralizado de los datos otorga máxima resiliencia a la operación física de las tiendas:

* **Pérdida de Internet o Caída del Servidor Central:** Si el túnel VPN se cae, el Middleware central no podrá alcanzar al mini-servidor de la sede. 
* **Encolamiento Natural:** Durante la caída, las cajas ICG seguirán guardando sus ventas localmente en el mini-servidor de la sede de forma ininterrumpida. Las ventas se "encolan" de forma pasiva en la tabla local.
* **Recuperación (De-queue):** En el instante en que el servicio de internet o VPN se restablece, el Middleware central volverá a alcanzar la IP del mini-servidor y extraerá en lote todas las facturas que se generaron durante el tiempo de desconexión, enviándolas al Core API para su transmisión a la DIAN.