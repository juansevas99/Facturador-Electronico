from lxml import etree
from ..domain.models import VentaDTO, NotaCreditoDTO, NotaDebitoDTO
from .interfaces import IConstructorSeccion

class ConstructorMetadatosNotaCreditoPOS(IConstructorSeccion):
    """
    Inyecta los metadatos básicos obligatorios para una Nota de Ajuste POS (Credit Note).
    """
    def aplicar(self, root: etree.Element, documento: NotaCreditoDTO):
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}UBLVersionID").text = "UBL 2.1"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}CustomizationID").text = "10"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ProfileID").text = "DIAN 2.1: Nota de Ajuste de Documento Equivalente POS"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(documento.codigo_venta)
        
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueDate").text = documento.fecha.isoformat()
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueTime").text = documento.hora.strftime("%H:%M:%S-05:00")
        
        # En una Nota de Ajuste, el InvoiceTypeCode suele omitirse ya que la estructura raíz CreditNote y ProfileID 
        # son suficientes, pero si la DIAN exige un código específico, aquí se colocaría (ej: 91).
        # Para el Anexo 1.0 POS, el ProfileID dicta la pauta.
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}DocumentCurrencyCode").text = "COP"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineCountNumeric").text = str(len(documento.lineas))


class ConstructorReferenciaFactura(IConstructorSeccion):
    """
    Construye el nodo cac:BillingReference que vincula esta nota con la factura/POS original.
    """
    def aplicar(self, root: etree.Element, documento: NotaCreditoDTO):
        if not documento.factura_referencia:
            return

        billing_reference = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}BillingReference")
        invoice_doc_ref = etree.SubElement(billing_reference, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}InvoiceDocumentReference")
        
        etree.SubElement(invoice_doc_ref, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(documento.factura_referencia)
        
        if documento.cude_referencia:
            etree.SubElement(invoice_doc_ref, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}UUID", schemeName="CUDE-SHA384").text = documento.cude_referencia
        
        if documento.fecha_factura_referencia:
            etree.SubElement(invoice_doc_ref, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueDate").text = documento.fecha_factura_referencia.isoformat()


class ConstructorMotivoAnulacion(IConstructorSeccion):
    """
    Construye el nodo cac:DiscrepancyResponse que explica el motivo de la Nota Crédito.
    """
    def aplicar(self, root: etree.Element, documento: NotaCreditoDTO):
        if not documento.codigo_motivo_anulacion:
            return
            
        discrepancy = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}DiscrepancyResponse")
        
        # Opcionalmente se puede referenciar de nuevo la factura aquí
        if documento.factura_referencia:
            etree.SubElement(discrepancy, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ReferenceID").text = str(documento.factura_referencia)
            
        etree.SubElement(discrepancy, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ResponseCode").text = documento.codigo_motivo_anulacion
        
        if documento.descripcion_motivo:
            etree.SubElement(discrepancy, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Description").text = documento.descripcion_motivo

class ConstructorLineasNotaCredito(IConstructorSeccion):
    """
    Construye los nodos cac:CreditNoteLine iterando sobre las lineas del documento.
    """
    def aplicar(self, root: etree.Element, documento: NotaCreditoDTO):
        for idx, linea in enumerate(documento.lineas, start=1):
            linea_xml = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}CreditNoteLine")
            
            etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(idx)
            
            if hasattr(linea, 'cantidad'):
                etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}CreditedQuantity", unitCode="94").text = f"{linea.cantidad:.2f}"
            
            if hasattr(linea, 'total_linea_sin_impuestos'):
                etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineExtensionAmount", currencyID="COP").text = f"{linea.total_linea_sin_impuestos:.2f}"
            
            # Item
            item_xml = etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Item")
            if hasattr(linea, 'descripcion'):
                etree.SubElement(item_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Description").text = linea.descripcion
                
            # Price
            price_xml = etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Price")
            if hasattr(linea, 'precio_unitario_sin_impuestos'):
                etree.SubElement(price_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}PriceAmount", currencyID="COP").text = f"{linea.precio_unitario_sin_impuestos:.2f}"

class ConstructorMetadatosNotaDebitoPOS(IConstructorSeccion):
    """
    Inyecta los metadatos básicos obligatorios para una Nota de Ajuste POS (Debit Note).
    """
    def aplicar(self, root: etree.Element, documento: NotaDebitoDTO):
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}UBLVersionID").text = "UBL 2.1"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}CustomizationID").text = "10"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ProfileID").text = "DIAN 2.1: Nota de Ajuste de Documento Equivalente POS"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(documento.codigo_venta)
        
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueDate").text = documento.fecha.isoformat()
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}IssueTime").text = documento.hora.strftime("%H:%M:%S-05:00")
        
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}DocumentCurrencyCode").text = "COP"
        etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineCountNumeric").text = str(len(documento.lineas))

class ConstructorTotalesNotaDebito(IConstructorSeccion):
    """
    Construye el nodo cac:RequestedMonetaryTotal requerido por DebitNote.
    """
    def aplicar(self, root: etree.Element, documento: NotaDebitoDTO):
        totales = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}RequestedMonetaryTotal")
        
        etree.SubElement(totales, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineExtensionAmount", currencyID="COP").text = f"{documento.subtotal_sin_impuestos:.2f}"
        etree.SubElement(totales, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxExclusiveAmount", currencyID="COP").text = f"{documento.subtotal_sin_impuestos:.2f}"
        etree.SubElement(totales, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxInclusiveAmount", currencyID="COP").text = f"{documento.total_con_impuestos:.2f}"
        etree.SubElement(totales, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}PayableAmount", currencyID="COP").text = f"{documento.total_a_pagar:.2f}"

class ConstructorLineasNotaDebito(IConstructorSeccion):
    """
    Construye los nodos cac:DebitNoteLine iterando sobre las lineas del documento.
    """
    def aplicar(self, root: etree.Element, documento: NotaDebitoDTO):
        for idx, linea in enumerate(documento.lineas, start=1):
            linea_xml = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}DebitNoteLine")
            
            etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(idx)
            
            if hasattr(linea, 'cantidad'):
                etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}DebitedQuantity", unitCode="94").text = f"{linea.cantidad:.2f}"
            
            if hasattr(linea, 'total_linea_sin_impuestos'):
                etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineExtensionAmount", currencyID="COP").text = f"{linea.total_linea_sin_impuestos:.2f}"
            
            # Item
            item_xml = etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Item")
            if hasattr(linea, 'descripcion'):
                etree.SubElement(item_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Description").text = linea.descripcion
                
            # Price
            price_xml = etree.SubElement(linea_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Price")
            if hasattr(linea, 'precio_unitario_sin_impuestos'):
                etree.SubElement(price_xml, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}PriceAmount", currencyID="COP").text = f"{linea.precio_unitario_sin_impuestos:.2f}"
