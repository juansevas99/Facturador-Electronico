from dataclasses import dataclass, field
from typing import List, Optional
from datetime import date, time

@dataclass
class ClienteDTO:
    """Representa al comprador (puede ser genérico 222222222222)"""
    identificacion: str
    nombre: str
    tipo_documento: str = "13" # 13 = Cédula, 31 = NIT por defecto
    email: Optional[str] = None

@dataclass
class ImpuestoResumenDTO:
    """Representa un impuesto calculado y sumarizado en la tirilla"""
    id_impuesto: str # 01=IVA, 34=IBUA, 35=ICUI, 22=Bolsas
    nombre_impuesto: str
    base_gravable: float
    valor_impuesto: float
    porcentaje: Optional[float] = None # Aplica a IVA/ICUI
    cantidad_base: Optional[float] = None # Aplica a IBUA (mililitros) o INPP (gramos)
    valor_por_unidad: Optional[float] = None # Aplica a IBUA/INPP

@dataclass
class LineaArticuloDTO:
    """Representa un producto escaneado en la caja"""
    consecutivo: int
    codigo_barras: str
    descripcion: str
    cantidad: float
    precio_unitario_sin_impuestos: float # <cbc:PriceAmount>
    total_linea_sin_impuestos: float # <cbc:LineExtensionAmount> (Precio * Cant)
    
    # Flags para el Motor de Reglas Fiscales
    aplica_iva: bool = True
    porcentaje_iva: float = 19.0
    aplica_ibua: bool = False
    mililitros_totales: float = 0.0
    aplica_icui: bool = False
    porcentaje_icui: float = 0.0
    es_bolsa_plastica: bool = False
    
    # Impuestos ya liquidados (Llenados por la Capa 2)
    impuestos_liquidados: List[ImpuestoResumenDTO] = field(default_factory=list)
    
@dataclass
class VentaDTO:
    """El objeto raíz que representa el Tiquete POS completo (Capa de Dominio)"""
    codigo_venta: str # Consecutivo interno de ICG
    fecha: date
    hora: time
    
    # Info Caja
    placa_caja: str
    ubicacion_caja: str
    cajero: str
    tipo_caja: str
    
    # Cliente
    cliente: ClienteDTO
    
    # Lineas (Productos)
    lineas: List[LineaArticuloDTO] = field(default_factory=list)
    
    # Totales (Llenados por la Capa 2 tras sumarizar las líneas)
    subtotal_sin_impuestos: float = 0.0 # <cbc:TaxExclusiveAmount>
    total_con_impuestos: float = 0.0 # <cbc:TaxInclusiveAmount>
    total_a_pagar: float = 0.0 # <cbc:PayableAmount>
    
    # Resumen Global de Impuestos (Agrupados por id_impuesto)
    impuestos_globales: List[ImpuestoResumenDTO] = field(default_factory=list)
    
@dataclass
class NotaCreditoDTO(VentaDTO):
    """Representa una Nota de Ajuste POS (Nota Crédito)"""
    factura_referencia: str = "" # Número de la factura/POS original que se está anulando
    cude_referencia: str = "" # CUDE de la factura original
    fecha_factura_referencia: Optional[date] = None
    codigo_motivo_anulacion: str = "2" # Ej: '2' = Anulación de documento
    descripcion_motivo: str = "Anulación total del documento"

@dataclass
class NotaDebitoDTO(VentaDTO):
    """Representa una Nota de Ajuste POS (Nota Débito)"""
    factura_referencia: str = "" # Número de la factura/POS original
    cude_referencia: str = "" # CUDE de la factura original
    fecha_factura_referencia: Optional[date] = None
    codigo_motivo_anulacion: str = "2" # Ej: '2' = Incremento de valor
    descripcion_motivo: str = "Incremento de valor del documento"
