from lxml import etree
from ..domain.models import VentaDTO
from .interfaces import IConstructorSeccion

class ConstructorEmisor(IConstructorSeccion):
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        supplier_party = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}AccountingSupplierParty")
        party = etree.SubElement(supplier_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Party")
        
        party_name = etree.SubElement(party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}PartyName")
        etree.SubElement(party_name, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Name").text = "MI EMPRESA SAS"
        
        tax_scheme_party = etree.SubElement(party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}PartyTaxScheme")
        etree.SubElement(tax_scheme_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}RegistrationName").text = "MI EMPRESA SAS"
        company_id = etree.SubElement(tax_scheme_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}CompanyID", schemeID="13", schemeName="31", schemeAgencyID="195", schemeAgencyName="CO, DIAN (Dirección de Impuestos y Aduanas Nacionales)")
        company_id.text = "900000000"
        
        tax_scheme = etree.SubElement(tax_scheme_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxScheme")
        etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = "01"
        etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Name").text = "IVA"

class ConstructorCliente(IConstructorSeccion):
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        customer_party = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}AccountingCustomerParty")
        party = etree.SubElement(customer_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Party")
        
        identification = etree.SubElement(party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}PartyIdentification")
        id_element = etree.SubElement(identification, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID", schemeID=documento.cliente.tipo_documento)
        id_element.text = documento.cliente.identificacion
        
        name_party = etree.SubElement(party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}PartyName")
        etree.SubElement(name_party, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Name").text = documento.cliente.nombre

class ConstructorTotales(IConstructorSeccion):
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        # 1. TaxTotal (Uno obligatorio, incluso si es 0.0)
        tax_total = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxTotal")
        total_impuestos = sum(imp.valor_impuesto for imp in documento.impuestos_globales) if documento.impuestos_globales else 0.0
        etree.SubElement(tax_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxAmount", currencyID="COP").text = "{:.2f}".format(total_impuestos)
        
        # Subtotales por cada tipo de impuesto
        if documento.impuestos_globales:
            for imp in documento.impuestos_globales:
                tax_subtotal = etree.SubElement(tax_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxSubtotal")
                etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxableAmount", currencyID="COP").text = "{:.2f}".format(imp.base_gravable)
                etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxAmount", currencyID="COP").text = "{:.2f}".format(imp.valor_impuesto)
                
                tax_category = etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxCategory")
                etree.SubElement(tax_category, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Percent").text = "{:.2f}".format(imp.porcentaje if imp.porcentaje else 0.0)
                
                tax_scheme = etree.SubElement(tax_category, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxScheme")
                etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = imp.id_impuesto
                etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Name").text = imp.nombre_impuesto
        else:
            # Si no hay impuestos, UBL exige enviar un TaxSubtotal en 0 (bienes exentos)
            tax_subtotal = etree.SubElement(tax_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxSubtotal")
            etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxableAmount", currencyID="COP").text = "{:.2f}".format(documento.subtotal_sin_impuestos)
            etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxAmount", currencyID="COP").text = "0.00"
            tax_category = etree.SubElement(tax_subtotal, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxCategory")
            etree.SubElement(tax_category, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Percent").text = "0.00"
            tax_scheme = etree.SubElement(tax_category, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}TaxScheme")
            etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = "01"
            etree.SubElement(tax_scheme, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Name").text = "IVA"

        # 2. LegalMonetaryTotal (Obligatorio)
        legal_total = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}LegalMonetaryTotal")
        etree.SubElement(legal_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineExtensionAmount", currencyID="COP").text = "{:.2f}".format(documento.subtotal_sin_impuestos)
        etree.SubElement(legal_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxExclusiveAmount", currencyID="COP").text = "{:.2f}".format(documento.subtotal_sin_impuestos)
        etree.SubElement(legal_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}TaxInclusiveAmount", currencyID="COP").text = "{:.2f}".format(documento.total_con_impuestos)
        etree.SubElement(legal_total, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}PayableAmount", currencyID="COP").text = "{:.2f}".format(documento.total_a_pagar)

class ConstructorLineas(IConstructorSeccion):
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        for linea in documento.lineas:
            invoice_line = etree.SubElement(root, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}InvoiceLine")
            etree.SubElement(invoice_line, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}ID").text = str(linea.consecutivo)
            etree.SubElement(invoice_line, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}InvoicedQuantity", unitCode="EA").text = str(linea.cantidad)
            etree.SubElement(invoice_line, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}LineExtensionAmount", currencyID="COP").text = "{:.2f}".format(linea.total_linea_sin_impuestos)
            
            item = etree.SubElement(invoice_line, "{urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2}Item")
            etree.SubElement(item, "{urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2}Description").text = linea.descripcion
