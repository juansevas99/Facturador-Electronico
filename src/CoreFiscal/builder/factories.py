from .generador import GeneradorXMLUniversal
from .secciones_pos import ConstructorMetadatosPOS, ConstructorExtensionCajaPOS
from .secciones_comunes import ConstructorEmisor, ConstructorCliente, ConstructorTotales, ConstructorLineas

def crear_generador_factura_pos() -> GeneradorXMLUniversal:
    """
    Ensambla y retorna un GeneradorXMLUniversal configurado específicamente
    para construir Documentos Equivalentes POS (InvoiceTypeCode 20).
    """
    estrategias_pos = [
        ConstructorExtensionCajaPOS(),
        ConstructorMetadatosPOS(),
        ConstructorEmisor(),
        ConstructorCliente(),
        ConstructorTotales(),
        ConstructorLineas()
    ]
    
    return GeneradorXMLUniversal(nombre_raiz="Invoice", estrategias_seccion=estrategias_pos)

# En el futuro, aquí agregaremos:
# def crear_generador_nota_credito_pos() -> GeneradorXMLUniversal:
#     ...

from .secciones_notas import ConstructorMetadatosNotaCreditoPOS, ConstructorReferenciaFactura, ConstructorMotivoAnulacion, ConstructorLineasNotaCredito

def crear_generador_nota_credito_pos() -> GeneradorXMLUniversal:
    """
    Ensambla y retorna un GeneradorXMLUniversal configurado específicamente
    para construir Notas de Ajuste del Documento Equivalente POS (CreditNote).
    """
    estrategias_nota = [
        ConstructorExtensionCajaPOS(), # Comparte la extensión de caja POS
        ConstructorMetadatosNotaCreditoPOS(),
        ConstructorMotivoAnulacion(),   # DiscrepancyResponse (antes de AccountingSupplierParty)
        ConstructorReferenciaFactura(), # BillingReference (antes de AccountingSupplierParty)
        ConstructorEmisor(),
        ConstructorCliente(),
        ConstructorTotales(),
        ConstructorLineasNotaCredito()
    ]
    
    # IMPORTANTE: Nota Crédito usa la raíz 'CreditNote' y un namespace principal distinto al de Invoice
    # Por ahora el GeneradorUniversal asume Invoice-2, deberemos ajustar esto si falla la validación XSD, 
    # pero a nivel de estructura XML los nodos se formarán correctamente.
    return GeneradorXMLUniversal(nombre_raiz="CreditNote", estrategias_seccion=estrategias_nota)


from .secciones_notas import ConstructorMetadatosNotaDebitoPOS, ConstructorTotalesNotaDebito, ConstructorLineasNotaDebito

def crear_generador_nota_debito_pos() -> GeneradorXMLUniversal:
    """
    Ensambla y retorna un GeneradorXMLUniversal configurado específicamente
    para construir Notas de Ajuste del Documento Equivalente POS (DebitNote).
    """
    estrategias_nota_debito = [
        ConstructorExtensionCajaPOS(), # Comparte la extensión de caja POS
        ConstructorMetadatosNotaDebitoPOS(),
        ConstructorMotivoAnulacion(),   # DiscrepancyResponse
        ConstructorReferenciaFactura(), # BillingReference
        ConstructorEmisor(),
        ConstructorCliente(),
        ConstructorTotalesNotaDebito(), # Utiliza RequestedMonetaryTotal
        ConstructorLineasNotaDebito()   # Utiliza DebitNoteLine
    ]
    
    return GeneradorXMLUniversal(nombre_raiz="DebitNote", estrategias_seccion=estrategias_nota_debito)
