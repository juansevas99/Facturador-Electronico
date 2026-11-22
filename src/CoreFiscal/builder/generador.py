from lxml import etree
from typing import List
from ..domain.models import VentaDTO
from .interfaces import IConstructorSeccion

class GeneradorXMLUniversal:
    """
    Orquestador principal del patrón Builder/Strategy.
    Recibe una lista de 'estrategias' (legos) y las ejecuta en orden
    para ensamblar un documento XML final.
    """
    def __init__(self, nombre_raiz: str, estrategias_seccion: List[IConstructorSeccion]):
        self.nombre_raiz = nombre_raiz
        self.estrategias = estrategias_seccion
        self.nsmap = {
            None: "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2",
            "cac": "urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2",
            "cbc": "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2",
            "ext": "urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2",
            "sts": "dian:gov:co:facturaelectronica:Structures-2-1"
        }

    def construir(self, documento: VentaDTO) -> bytes:
        # 1. Determinamos el namespace principal según el tipo de documento
        if self.nombre_raiz == "CreditNote":
            ns_principal = "urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
        elif self.nombre_raiz == "DebitNote":
            ns_principal = "urn:oasis:names:specification:ubl:schema:xsd:DebitNote-2"
        else:
            ns_principal = "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
            
        # Ajustamos el nsmap principal (None) dinámicamente
        nsmap_dinamico = self.nsmap.copy()
        nsmap_dinamico[None] = ns_principal
        
        root_ns = f"{{{ns_principal}}}{self.nombre_raiz}"
        root = etree.Element(root_ns, nsmap=nsmap_dinamico)

        
        # 2. Ejecutamos cada "Lego" o estrategia en el orden configurado
        for estrategia in self.estrategias:
            estrategia.aplicar(root, documento)
            
        # 3. Retornamos el XML generado
        return etree.tostring(root, encoding="UTF-8", xml_declaration=True, pretty_print=True)
