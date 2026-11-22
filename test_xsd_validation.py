import sys
import os
from datetime import date, time
from lxml import etree

sys.path.append(os.path.abspath(os.path.dirname(__file__)))

from src.CoreFiscal.domain.models import VentaDTO, NotaCreditoDTO, NotaDebitoDTO, ClienteDTO, LineaArticuloDTO, ImpuestoResumenDTO
from src.CoreFiscal.builder.factories import (
    crear_generador_factura_pos,
    crear_generador_nota_credito_pos,
    crear_generador_nota_debito_pos
)

def validar_xml(xml_bytes, xsd_path):
    print(f"\n[INFO] Validando contra: {os.path.basename(xsd_path)}")
    try:
        # Usar el directorio base del XSD para resolver imports locales correctamente
        base_dir = os.path.dirname(xsd_path)
        # Cambiamos al directorio del xsd para que los imports relativos funcionen bien (opcional pero seguro)
        original_cwd = os.getcwd()
        os.chdir(base_dir)
        
        schema_doc = etree.parse(os.path.basename(xsd_path))
        schema = etree.XMLSchema(schema_doc)
        
        os.chdir(original_cwd) # Volver
        
        xml_doc = etree.fromstring(xml_bytes)
        schema.assertValid(xml_doc)
        print("[EXITO] El XML generado cumple 100% con el esquema XSD.")
    except etree.DocumentInvalid as e:
        print(f"[ERROR DE VALIDACIÓN XSD]: El documento no es válido.")
        for error in schema.error_log:
            print(f"  - Linea {error.line}: {error.message}")
        if 'original_cwd' in locals():
            os.chdir(original_cwd)
    except Exception as e:
        print(f"[ERROR]: {e}")
        if 'original_cwd' in locals():
            os.chdir(original_cwd)

def main():
    cliente_mock = ClienteDTO(identificacion="222222222222", nombre="Consumidor Final")
    linea_mock = LineaArticuloDTO(consecutivo=1, codigo_barras="770123456789", descripcion="Café Americano", cantidad=2.0, precio_unitario_sin_impuestos=2500.0, total_linea_sin_impuestos=5000.0)
    impuesto_mock = ImpuestoResumenDTO(id_impuesto="01", nombre_impuesto="IVA", base_gravable=5000.0, valor_impuesto=950.0, porcentaje=19.0)

    # 1. Factura
    venta = VentaDTO(
        codigo_venta="POS-001", fecha=date.today(), hora=time(14, 30, 0), placa_caja="CAJA-01",
        ubicacion_caja="Piso 1", cajero="Juan Perez", tipo_caja="Principal", cliente=cliente_mock,
        lineas=[linea_mock], subtotal_sin_impuestos=5000.0, total_con_impuestos=5950.0,
        total_a_pagar=5950.0, impuestos_globales=[impuesto_mock]
    )

    # 2. Nota Crédito
    nota_credito = NotaCreditoDTO(
        codigo_venta="NC-POS-001", fecha=date.today(), hora=time(15, 0, 0), placa_caja="CAJA-01",
        ubicacion_caja="Piso 1", cajero="Juan Perez", tipo_caja="Principal", cliente=cliente_mock,
        lineas=[linea_mock], subtotal_sin_impuestos=5000.0, total_con_impuestos=5950.0,
        total_a_pagar=5950.0, impuestos_globales=[impuesto_mock], factura_referencia="POS-001",
        cude_referencia="a1b2c3d4e5f6hashcude", fecha_factura_referencia=date.today(),
        codigo_motivo_anulacion="2", descripcion_motivo="Devolución"
    )

    # 3. Nota Débito
    nota_debito = NotaDebitoDTO(
        codigo_venta="ND-POS-001", fecha=date.today(), hora=time(15, 30, 0), placa_caja="CAJA-01",
        ubicacion_caja="Piso 1", cajero="Juan Perez", tipo_caja="Principal", cliente=cliente_mock,
        lineas=[linea_mock], subtotal_sin_impuestos=5000.0, total_con_impuestos=5950.0,
        total_a_pagar=5950.0, impuestos_globales=[impuesto_mock], factura_referencia="POS-001",
        cude_referencia="a1b2c3d4e5f6hashcude", fecha_factura_referencia=date.today(),
        codigo_motivo_anulacion="2", descripcion_motivo="Ajuste de precio"
    )

    # Generar XMLs
    xml_inv = crear_generador_factura_pos().construir(venta)
    xml_nc = crear_generador_nota_credito_pos().construir(nota_credito)
    xml_nd = crear_generador_nota_debito_pos().construir(nota_debito)

    # Paths XSD
    base_path = os.path.dirname(__file__)
    maindoc_path = os.path.join(base_path, "src", "CoreFiscal", "fuentes", "XSD", "POS", "maindoc")
    
    xsd_inv = os.path.join(maindoc_path, "UBL-Invoice-2.1.xsd")
    xsd_nc = os.path.join(maindoc_path, "UBL-CreditNote-2.1.xsd")
    xsd_nd = os.path.join(maindoc_path, "UBL-DebitNote-2.1.xsd")

    validar_xml(xml_inv, xsd_inv)
    validar_xml(xml_nc, xsd_nc)
    validar_xml(xml_nd, xsd_nd)

if __name__ == "__main__":
    main()
