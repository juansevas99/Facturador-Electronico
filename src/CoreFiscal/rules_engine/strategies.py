from abc import ABC, abstractmethod
from typing import List
from ..domain.models import VentaDTO, LineaArticuloDTO, ImpuestoResumenDTO

class IEstrategiaImpuesto(ABC):
    """Interfaz base (Contrato) para calcular cualquier impuesto"""
    @abstractmethod
    def calcular_impuesto(self, articulo: LineaArticuloDTO) -> ImpuestoResumenDTO | None:
        pass

class EstrategiaIVA(IEstrategiaImpuesto):
    def calcular_impuesto(self, articulo: LineaArticuloDTO) -> ImpuestoResumenDTO | None:
        if not articulo.aplica_iva:
            return None
            
        valor_impuesto = articulo.total_linea_sin_impuestos * (articulo.porcentaje_iva / 100.0)
        
        return ImpuestoResumenDTO(
            id_impuesto="01", # DIAN Código IVA
            nombre_impuesto="IVA",
            base_gravable=articulo.total_linea_sin_impuestos,
            valor_impuesto=round(valor_impuesto, 2),
            porcentaje=articulo.porcentaje_iva
        )

class EstrategiaIBUA(IEstrategiaImpuesto):
    def calcular_impuesto(self, articulo: LineaArticuloDTO) -> ImpuestoResumenDTO | None:
        if not articulo.aplica_ibua:
            return None
            
        # El IBUA para 2024 (ejemplo ficticio/real) podría ser $18 por cada 100ml.
        # Aquí articulo.mililitros_totales ya viene con los mililitros totales de todos los items de esa línea.
        TARIFA_POR_MILILITRO = 18.0
        
        # En la DIAN el IBUA se cobra por mililitro (o grupos de 100ml). Simplificando:
        valor_impuesto = articulo.mililitros_totales * TARIFA_POR_MILILITRO
        
        return ImpuestoResumenDTO(
            id_impuesto="34", # DIAN Código IBUA
            nombre_impuesto="IBUA",
            base_gravable=articulo.total_linea_sin_impuestos, # Para propósitos XML
            valor_impuesto=round(valor_impuesto, 2),
            cantidad_base=articulo.mililitros_totales,
            valor_por_unidad=TARIFA_POR_MILILITRO
        )

class EstrategiaICUI(IEstrategiaImpuesto):
    def calcular_impuesto(self, articulo: LineaArticuloDTO) -> ImpuestoResumenDTO | None:
        if not articulo.aplica_icui:
            return None
            
        # ICUI usa un porcentaje, e.g. 15% en 2024
        valor_impuesto = articulo.total_linea_sin_impuestos * (articulo.porcentaje_icui / 100.0)
        
        return ImpuestoResumenDTO(
            id_impuesto="35", # DIAN Código ICUI
            nombre_impuesto="ICUI",
            base_gravable=articulo.total_linea_sin_impuestos,
            valor_impuesto=round(valor_impuesto, 2),
            porcentaje=articulo.porcentaje_icui
        )

class LiquidadorFiscal:
    """Motor que orquesta las estrategias de impuestos"""
    def __init__(self):
        self._estrategias: List[IEstrategiaImpuesto] = []
        
    def registrar_estrategia(self, estrategia: IEstrategiaImpuesto):
        self._estrategias.append(estrategia)
        
    def liquidar_venta(self, venta: VentaDTO) -> VentaDTO:
        subtotal_global = 0.0
        total_impuestos_global = 0.0
        dict_impuestos_globales = {} # Para agrupar impuestos por ID a nivel global
        
        for linea in venta.lineas:
            subtotal_global += linea.total_linea_sin_impuestos
            
            for estrategia in self._estrategias:
                impuesto = estrategia.calcular_impuesto(linea)
                if impuesto:
                    linea.impuestos_liquidados.append(impuesto)
                    total_impuestos_global += impuesto.valor_impuesto
                    
                    # Agrupar a nivel global (Para el <cac:TaxTotal> principal)
                    if impuesto.id_impuesto not in dict_impuestos_globales:
                        # Crear copia para el global
                        dict_impuestos_globales[impuesto.id_impuesto] = ImpuestoResumenDTO(
                            id_impuesto=impuesto.id_impuesto,
                            nombre_impuesto=impuesto.nombre_impuesto,
                            base_gravable=0.0,
                            valor_impuesto=0.0,
                            porcentaje=impuesto.porcentaje,
                            cantidad_base=0.0 if impuesto.cantidad_base else None,
                            valor_por_unidad=impuesto.valor_por_unidad
                        )
                        
                    global_imp = dict_impuestos_globales[impuesto.id_impuesto]
                    global_imp.base_gravable += impuesto.base_gravable
                    global_imp.valor_impuesto += impuesto.valor_impuesto
                    if impuesto.cantidad_base:
                        global_imp.cantidad_base += impuesto.cantidad_base
                        
        # Guardar totales en la Venta
        venta.subtotal_sin_impuestos = round(subtotal_global, 2)
        venta.total_con_impuestos = round(subtotal_global + total_impuestos_global, 2)
        venta.total_a_pagar = venta.total_con_impuestos
        venta.impuestos_globales = list(dict_impuestos_globales.values())
        
        return venta
