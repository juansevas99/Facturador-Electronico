from abc import ABC, abstractmethod
from lxml import etree
from ..domain.models import VentaDTO

class IConstructorSeccion(ABC):
    """
    Contrato base (Strategy) que deben cumplir todos los bloques
    constructores del XML. Cada sección sabe inyectar sus propios
    nodos en el documento raíz.
    """
    
    @abstractmethod
    def aplicar(self, root: etree.Element, documento: VentaDTO):
        """
        Modifica el elemento raíz agregándole los nodos correspondientes.
        """
        pass
