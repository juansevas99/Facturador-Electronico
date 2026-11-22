import sys
import os
from datetime import date, time

# Agregar el directorio raíz al path para importar correctamente
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from src.CoreFiscal.domain.models import VentaDTO, NotaCreditoDTO, ClienteDTO, LineaArticuloDTO, ImpuestoResumenDTO
from src.CoreFiscal.builder.factories import crear_generador_factura_pos, crear_generador_nota_credito_pos

def main():
    print("=========================================")
    print("  TEST: CONSTRUCTORES XML (COMPOSICIÓN)")
    print("=========================================\n")

    # 1. Crear datos de prueba (Mock)
    cliente_mock = ClienteDTO(
        identificacion="222222222222",
        nombre="Consumidor Final"
    )

    linea_mock = LineaArticuloDTO(
        consecutivo=1,
        codigo_barras="770123456789",
        descripcion="Café Americano",
        cantidad=2.0,
        precio_unitario_sin_impuestos=2500.0,
        total_linea_sin_impuestos=5000.0,
    )

    impuesto_mock = ImpuestoResumenDTO(
        id_impuesto="01",
        nombre_impuesto="IVA",
        base_gravable=5000.0,
        valor_impuesto=950.0,
        porcentaje=19.0
    )

    # 2. Mockear una VENTA (Factura POS)
    venta = VentaDTO(
        codigo_venta="POS-001",
        fecha=date.today(),
        hora=time(14, 30, 0),
        placa_caja="CAJA-01",
        ubicacion_caja="Piso 1",
        cajero="Juan Perez",
        tipo_caja="Principal",
        cliente=cliente_mock,
        lineas=[linea_mock],
        subtotal_sin_impuestos=5000.0,
        total_con_impuestos=5950.0,
        total_a_pagar=5950.0,
        impuestos_globales=[impuesto_mock]
    )

    # 3. Mockear una NOTA CRÉDITO POS
    nota = NotaCreditoDTO(
        codigo_venta="NC-POS-001",
        fecha=date.today(),
        hora=time(15, 0, 0),
        placa_caja="CAJA-01",
        ubicacion_caja="Piso 1",
        cajero="Juan Perez",
        tipo_caja="Principal",
        cliente=cliente_mock,
        lineas=[linea_mock],
        subtotal_sin_impuestos=5000.0,
        total_con_impuestos=5950.0,
        total_a_pagar=5950.0,
        impuestos_globales=[impuesto_mock],
        factura_referencia="POS-001",
        cude_referencia="a1b2c3d4e5f6hashcude",
        fecha_factura_referencia=date.today(),
        codigo_motivo_anulacion="2",
        descripcion_motivo="Devolución por producto defectuoso"
    )

    # 4. Probar Generador de Factura POS
    print("-> GENERANDO FACTURA POS...")
    generador_factura = crear_generador_factura_pos()
    xml_factura = generador_factura.construir(venta)
    print(xml_factura.decode('utf-8'))
    print("\n------------------------------------------------\n")

    # 5. Probar Generador de Nota Crédito POS
    print("-> GENERANDO NOTA CRÉDITO POS...")
    generador_nota = crear_generador_nota_credito_pos()
    xml_nota = generador_nota.construir(nota)
    print(xml_nota.decode('utf-8'))

if __name__ == "__main__":
    main()
