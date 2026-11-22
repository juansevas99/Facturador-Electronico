from lxml import etree
import os

from pathlib import Path

class DianXSDValidator:
    """
    Validador estricto que asegura que el XML generado cumple matemáticamente 
    con el esquema oficial (XSD) provisto por la DIAN para UBL 2.1.
    """
    def __init__(self, xsd_path: str = None):
        if xsd_path is None:
            # Si no se provee ruta, autodescubrir el esquema UBL-Invoice-2.1 por defecto para facturas POS
            base_dir = Path(__file__).parent.parent
            xsd_path_obj = base_dir / "fuentes" / "XSD" / "maindoc" / "UBL-Invoice-2.1.xsd"
            xsd_path = str(xsd_path_obj.resolve())
            
        if not os.path.exists(xsd_path):
            raise FileNotFoundError(f"El archivo XSD no existe en la ruta proporcionada: {xsd_path}")
            
        # Cargar y parsear el esquema oficial de la DIAN
        with open(xsd_path, 'rb') as f:
            xmlschema_doc = etree.parse(f)
            
        self.xmlschema = etree.XMLSchema(xmlschema_doc)

    def validar(self, xml_bytes: bytes) -> bool:
        """
        Toma el string/bytes del XML generado por el Builder y lo valida.
        Lanza ValueError si el XML está mal formado o viola el esquema.
        """
        try:
            xml_doc = etree.fromstring(xml_bytes)
        except etree.XMLSyntaxError as e:
            raise ValueError(f"Sintaxis XML inválida: {e}")
        
        # Validar el documento contra el XSD
        if not self.xmlschema.validate(xml_doc):
            errores = []
            for error in self.xmlschema.error_log:
                errores.append(f"Línea {error.line}: {error.message}")
                
            mensaje_error = "El XML no cumple con el esquema XSD de la DIAN:\n" + "\n".join(errores)
            raise ValueError(mensaje_error)
            
        return True
