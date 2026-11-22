from lxml import etree
from ..domain.models import VentaDTO
from .interfaces import IConstructorSeccion

class ConstructorMetadatosPOS(IConstructorSeccion):
    """
    Inyecta los metadatos básicos obligatorios para un Documento Equivalente POS.
    """
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}UBLVersionID").text = "UBL 2.1"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}CustomizationID").text = "10"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ProfileID").text = "DIAN 2.1: Documento Equivalente POS"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(documento.codigo_venta)
        
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueDate").text = documento.fecha.isoformat()
        # Agregar offset local si la hora no lo tiene (ej: -05:00 para Colombia)
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueTime").text = documento.hora.strftime("%H:%M:%S-05:00")
        
        # El InvoiceTypeCode 20 identifica al POS Equivalente
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}InvoiceTypeCode", name="Factura tipo punto de venta POS").text = "20"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}DocumentCurrencyCode").text = "COP"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineCountNumeric").text = str(len(documento.lineas))


class ConstructorExtensionCajaPOS(IConstructorSeccion):
    """
    Construye la extensión PuntoVenta exigida específicamente para POS.
    """
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        # Primero necesitamos o buscamos el nodo UBLExtensions general
        # (En una versión más robusta, habría un orquestador de extensiones,
        # pero por simplicidad lo inyectamos directamente aquí).
        ext_ubl_extensions = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2}UBLExtensions")
        
        ext = etree.SubElement(ext_ubl_extensions, "{urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2}UBLExtension")
        content = etree.SubElement(ext, "{urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2}ExtensionContent")
        
        pv = etree.SubElement(content, "PuntoVenta")
        info = etree.SubElement(pv, "InformacionCajaVenta")
        
        self._add_name_value(info, "PlacaCaja", documento.placa_caja)
        self._add_name_value(info, "UbicaciónCaja", documento.ubicacion_caja)
        self._add_name_value(info, "Cajero", documento.cajero)

    def _add_name_value(self, parent: etree.Element, name: str, value: str):
        etree.SubElement(parent, "Name").text = name
        etree.SubElement(parent, "Value").text = str(value)
