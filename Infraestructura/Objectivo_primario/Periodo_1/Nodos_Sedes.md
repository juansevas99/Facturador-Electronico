# Especificaciones Técnicas: Mini-Servidores de Sede (Periodo 1)

Este documento describe el rol, la conectividad y el hardware sugerido para los "Mini-servidores" o PCs que actuarán como nodos de concentración de datos en cada una de las 13 sucursales del Grupo Ramírez.

---

## 1. Rol en la Arquitectura (Nodos de Borde)

El mini-servidor instalado en cada sede tiene una función crítica en el nuevo modelo descentralizado de persistencia:

* **Concentrador Local (Hub):** Todas las cajas registradoras (POS) de la tienda guardarán sus transacciones de venta en la base de datos de este mini-servidor a través de la red LAN de la tienda.
* **Cola de Contingencia Natural:** Si la VPN hacia el Datacenter Central se interrumpe, las cajas pueden seguir operando normalmente porque la base de datos es local. Las ventas se acumularán pasivamente en este equipo.
* **Punto de Extracción (Endpoint):** El Middleware central (ubicado en `SRV-CORE-01`) "visitará" este mini-servidor a través de la VPN para leer las ventas nuevas.

---

## 2. Requerimientos de Hardware y Software

Dado que estos equipos no procesarán el XML ni firmarán documentos, sus requisitos son livianos, enfocados puramente en alojar el motor de base de datos de ICG (SQL Server Express).

* **Hardware Sugerido:** Mini-PC Industrial (ej. Intel NUC, Dell OptiPlex Micro) o un PC de escritorio de gama de entrada.
* **Procesador:** Intel Core i3 / Ryzen 3 o superior.
* **Memoria RAM:** Mínimo 8 GB (16 GB recomendado para SQL Server).
* **Almacenamiento:** Unidad SSD de 256 GB (para rápida escritura de transacciones).
* **Sistema Operativo:** Windows 10/11 Pro o Windows Server Essentials.
* **Motor de Base de Datos:** Microsoft SQL Server Express (gratuito) para alojar la BD de ICG.

---

## 3. Conectividad y Red

* **Red Local (LAN):** Conexión por cable Ethernet (Gigabit) al switch local de la tienda.
* **Direccionamiento IP:** IP Privada estática dentro de la VLAN de administración de la tienda.
* **VPN:** El router de la sede (ej. Mikrotik/TP-Link) enrutará el tráfico del puerto `1433` (SQL) de este equipo a través del túnel VPN hacia el Datacenter Central para que el Middleware pueda alcanzarlo.
