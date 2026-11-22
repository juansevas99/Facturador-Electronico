# 1. Reconocimiento del Estado Actual de la Empresa (Fase 1)

Este capítulo documenta la estructura organizacional, la huella operativa y el ecosistema tecnológico actual de la compañía a fecha de 2026, sirviendo como línea base para el diseño del nuevo Core de facturación electrónica.

---

## 1.1. Perfil Corporativo y Modelo de Negocio
La empresa opera como una **cadena de supermercados de categoría Premium**, enfocada en el comercio al por menor (Retail) de productos de alta gama, importados y de consumo masivo selecto. 

* **Tamaño de la organización:** 300 empleados activos.
* **Modelo transaccional predominante:** B2C (Business-to-Consumer) masivo en puntos de venta físicos, con un volumen crítico de transacciones diarias que migrarán del tiquete POS tradicional al Documento Equivalente Electrónico.

---

## 1.2. Estructura Organizacional y Roles Operativos
El capital humano de la empresa (300 colaboradores) está distribuido en seis áreas clave, las cuales interactúan directa o indirectamente con el sistema ERP y el flujo de caja:

| Área Funcional | Descripción del Rol en el Ecosistema | Impacto en el Proyecto |
| :--- | :--- | :--- |
| **Administración y Contabilidad** | Gestión financiera, auditoría de cierres de caja, conciliación fiscal y reportes ante la DIAN. | **Usuario principal** del Visualizador en Tiempo Real y administrador del Core. |
| **Compras** | Negociación con proveedores nacionales e internacionales. Generación de Órdenes de Compra (OC). | Responsables de alimentar las OC en el ERP para que el Core las indexe en el XML. |
| **Ventas / Comercial** | Estrategia de precios, promociones y gestión de piso de venta. | Generación de la dinámica comercial que alimenta al ERP. |
| **Cajeros (Puntos de Venta)** | Operación de terminales POS en las 13 sedes. Emisión síncrona de tiquetes y facturas. | **Usuario crítico.** El Middleware no debe afectar la velocidad de su pantalla de facturación. |
| **Distribuidores y Logística** | Despacho de mercancías, control de inventarios entre sedes y entregas a domicilio corporativas. | Consumidores de Notas Crédito/Débito por averías o devoluciones en ruta. |
| **Recursos Humanos** | Gestión de nómina, contratación y bienestar del personal. | Fuera del alcance inicial (Nómina electrónica se mantiene en su flujo actual). |

---

## 1.3. Huella Geográfica e Infraestructura de Red
La operación se encuentra distribuida en **13 sedes físicas** estratégicas, lo que exige una arquitectura de red tolerante a fallos de conectividad regional:

* **Ubicación de Sedes:** Cobertura en Bogotá D.C. y municipios aledaños del departamento de Cundinamarca.
* **Topología de Red Actual:** Cada sede cuenta con terminales de venta locales conectados a un servidor periférico de la tienda, los cuales sincronizan los datos de ventas hacia el servidor central de aplicaciones de la empresa (Arquitectura Híbrida).

---

## 1.4. Ecosistema Tecnológico y Flujo Fiscal Actual (Línea Base)

Actualmente, la empresa presenta una dependencia tecnológica externa para el cumplimiento de sus obligaciones fiscales: