USE [FLX_BD]
GO
/****** Objeto: Table [dbo].[FLX_APP_Mensajes] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_Mensajes](
	[Evento] [int] IDENTITY(1,1) NOT NULL,
	[Proceso] [int] NOT NULL,
	[Paso] [smallint] NOT NULL,
	[Pasos] [smallint] NOT NULL,
	[Texto] [varchar](500) NOT NULL,
	[Terminado] [smallint] NOT NULL,
 CONSTRAINT [PK_FLX_APP_Mensajes] PRIMARY KEY CLUSTERED 
(
	[Evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_APP_Mensajes_T1] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_Mensajes_T1](
	[Proceso] [int] NOT NULL,
	[Paso] [int] NOT NULL,
	[Registro] [varchar](8000) NOT NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_APP_Objetos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_Objetos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Contenedor] [int] NULL,
	[Nombre] [varchar](255) NOT NULL,
	[NombreMostrar] [varchar](255) NOT NULL,
	[Tipo] [varchar](255) NOT NULL,
	[MenuID] [int] NULL,
 CONSTRAINT [PK_FLX_APP_Objetos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_APP_Perfiles] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_Perfiles](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Empresa] [int] NOT NULL,
 CONSTRAINT [PK_FLX_Perfiles_1] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_APP_PerfilesEquivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_PerfilesEquivalencias](
	[Perfil] [int] NOT NULL,
	[TipoEmpleadoICG] [int] NOT NULL,
 CONSTRAINT [PK_FLX_APP_PerfilesEquivalencias] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[TipoEmpleadoICG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_APP_PermisosPerfil] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_APP_PermisosPerfil](
	[Perfil] [int] NOT NULL,
	[Objeto] [int] NOT NULL,
	[Permiso] [varchar](50) NULL,
 CONSTRAINT [PK_FLX_APP_PermisosPerfil] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[Objeto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Empresas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Empresas](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[BD] [varchar](255) NULL,
	[Estado] [smallint] NOT NULL,
 CONSTRAINT [PK_FLX_Empresas] PRIMARY KEY CLUSTERED 
(
	[Aplicacion] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Log] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Log](
	[Evento] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Maquina] [varchar](255) NOT NULL,
	[AplicacionFLX] [varchar](128) NULL,
	[Aplicacion] [varchar](128) NOT NULL,
	[Empresa] [int] NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[UsuarioAplicacion] [varchar](100) NULL,
	[Version] [varchar](128) NULL,
	[Objeto] [varchar](100) NOT NULL,
	[Mensaje] [varchar](8000) NOT NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Menu] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Menu](
	[ID] [int] NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Parent] [int] NULL,
	[Procedimiento] [varchar](255) NULL,
	[Ensamblado] [varchar](100) NULL,
	[Clase] [varchar](100) NULL,
	[Parametros] [varchar](500) NULL,
	[Pagina] [varchar](255) NULL,
 CONSTRAINT [PK_FLX_Menu] PRIMARY KEY CLUSTERED 
(
	[Aplicacion] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Menu_Descripciones] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Menu_Descripciones](
	[Id] [int] NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Idioma] [varchar](10) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
 CONSTRAINT [PK_FLX_Menu_Descripciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[Aplicacion] ASC,
	[Idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Prm_ListasValores] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Prm_ListasValores](
	[Aplicacion] [varchar](50) NOT NULL,
	[Empresa] [int] NOT NULL,
	[Lista] [int] NOT NULL,
	[TipoLista] [char](20) NULL,
	[OrigenValores] [varchar](4000) NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Prm_Parametros] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Prm_Parametros](
	[IDRegistro] [int] IDENTITY(1,1) NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Empresa] [int] NOT NULL,
	[Parametro] [varchar](255) NOT NULL,
	[Grupo] [varchar](50) NOT NULL,
	[Valor] [varchar](4000) NULL,
	[TipoDato] [smallint] NOT NULL,
	[Longitud] [smallint] NOT NULL,
	[Descripcion] [varchar](250) NOT NULL,
	[ListaValores] [int] NULL,
	[SeleccionMultiple] [smallint] NULL,
	[TipoClave] [smallint] NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Prm_Parametros_Descripciones] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Prm_Parametros_Descripciones](
	[Aplicacion] [varchar](50) NOT NULL,
	[Parametro] [varchar](255) NOT NULL,
	[Idioma] [varchar](10) NOT NULL,
	[Grupo] [varchar](50) NOT NULL,
	[Descripcion] [varchar](250) NOT NULL,
 CONSTRAINT [PK_FLX_Prm_Parametros_Descripciones] PRIMARY KEY CLUSTERED 
(
	[Aplicacion] ASC,
	[Parametro] ASC,
	[Idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Prm_ValoresLista] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Prm_ValoresLista](
	[Aplicacion] [varchar](50) NOT NULL,
	[Empresa] [int] NOT NULL,
	[Lista] [int] NOT NULL,
	[Valor] [varchar](50) NOT NULL,
	[Descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_T001] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_T001](
	[Registros] [int] NULL,
	[Host] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Usuarios] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Usuarios](
	[Aplicacion] [varchar](50) NOT NULL,
	[Empresa] [int] NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[Password] [varchar](25) NULL,
	[Perfil] [int] NOT NULL,
	[Estado] [smallint] NOT NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_FLX_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Aplicacion] ASC,
	[Empresa] ASC,
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FLX_Version] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLX_Version](
	[Consecutivo] [int] IDENTITY(1,1) NOT NULL,
	[Aplicacion] [varchar](50) NOT NULL,
	[Version] [int] NOT NULL,
	[Release] [int] NOT NULL,
	[Revision] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Usuario] [varchar](500) NULL,
	[Maquina] [varchar](50) NULL,
	[NuevosObjetos] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ALBCOMPRALIN] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ALBCOMPRALIN](
	[empresa] [int] NOT NULL,
	[numserie] [nvarchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[numserieAlbaran] [nvarchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[codarticulo] [int] NULL,
	[referencia] [nvarchar](15) NULL,
	[descripcion] [nvarchar](40) NULL,
	[color] [nvarchar](10) NULL,
	[talla] [nvarchar](10) NULL,
	[unidadestotal] [float] NULL,
	[unidadespagadas] [float] NULL,
	[precio] [float] NULL,
	[dto] [float] NULL,
	[total] [float] NULL,
	[tipoimpuesto] [smallint] NULL,
	[iva] [float] NULL,
	[req] [float] NULL,
	[codalmacen] [nvarchar](3) NULL,
	[lineaoculta] [nchar](1) NULL,
	[supedido] [nvarchar](15) NULL,
	[codformato] [int] NULL,
	[udsexpansion] [float] NULL,
	[expandida] [nvarchar](1) NULL,
	[totalexpansion] [float] NULL,
	[cargo1] [float] NULL,
	[cargo2] [float] NULL,
	[udsabonadas] [float] NULL,
	[abonode_numserie] [nvarchar](4) NULL,
	[abonode_numalbaran] [int] NULL,
	[abonode_n] [nvarchar](1) NULL,
	[porcretencion] [float] NULL,
	[tiporetencion] [int] NULL,
	[seriales] [nvarchar](4000) NULL,
	[idmotivo] [int] NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_ALBCOMPRALIN] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ALBVENTALIN] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ALBVENTALIN](
	[empresa] [int] NOT NULL,
	[numserie] [nvarchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[numserieAlbaran] [nvarchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[codarticulo] [int] NULL,
	[referencia] [nvarchar](15) NULL,
	[descripcion] [nvarchar](40) NULL,
	[color] [nvarchar](10) NULL,
	[talla] [nvarchar](10) NULL,
	[unidadestotal] [float] NULL,
	[unidadespagadas] [float] NULL,
	[precio] [float] NULL,
	[dto] [float] NULL,
	[total] [float] NULL,
	[coste] [float] NULL,
	[preciodefecto] [float] NULL,
	[tipoimpuesto] [smallint] NULL,
	[iva] [float] NULL,
	[req] [float] NULL,
	[codtarifa] [int] NULL,
	[codalmacen] [nvarchar](3) NULL,
	[lineaoculta] [nchar](1) NULL,
	[codvendedor] [int] NULL,
	[supedido] [nvarchar](15) NULL,
	[precioiva] [float] NULL,
	[codformato] [int] NULL,
	[udsexpansion] [float] NULL,
	[expandida] [nvarchar](1) NULL,
	[totalexpansion] [float] NULL,
	[costeiva] [float] NULL,
	[tipo] [nvarchar](2) NULL,
	[cargo1] [float] NULL,
	[cargo2] [float] NULL,
	[hora] [datetime] NULL,
	[udsabonadas] [float] NULL,
	[abonode_numserie] [nvarchar](4) NULL,
	[abonode_numalbaran] [int] NULL,
	[abonode_n] [nvarchar](1) NULL,
	[idpromocion] [int] NULL,
	[importeantespromocion] [float] NULL,
	[importeantespromocioniva] [float] NULL,
	[porcretencion] [float] NULL,
	[dtoantespromocion] [float] NULL,
	[stock] [float] NULL,
	[idmotivodto] [int] NULL,
	[detallemodif] [smallint] NULL,
	[detalledenumlinea] [smallint] NULL,
	[tipodelivery] [int] NULL,
	[tiporetencion] [int] NULL,
	[abonodelinea] [int] NULL,
	[idmotivoabono] [int] NULL,
	[seriales] [nvarchar](4000) NULL,
	[fechahora] [datetime] NOT NULL,
	[lotes] [nvarchar](4000) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_ALBVENTALIN] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_CamposExtras] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_CamposExtras](
	[empresa] [int] NOT NULL,
	[tabla] [varchar](50) NOT NULL,
	[campolibre] [varchar](100) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[pdf] [smallint] NOT NULL,
	[xml] [smallint] NOT NULL,
	[controlInterno1] [varchar](255) NOT NULL,
	[controlInterno2] [varchar](255) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[tipoCampo] [smallint] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_CamposExtras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tabla] ASC,
	[campolibre] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_CargosDtos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_CargosDtos_Equivalencias](
	[empresa] [int] NOT NULL,
	[codigo] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[ajustarBase] [smallint] NULL,
	[esNominal] [smallint] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_CargosDtos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codigo] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_CamposExtras] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_CamposExtras](
	[empresa] [int] NOT NULL,
	[tabla] [varchar](50) NOT NULL,
	[campolibre] [varchar](100) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[pdf] [smallint] NOT NULL,
	[xml] [smallint] NOT NULL,
	[controlInterno1] [varchar](255) NOT NULL,
	[controlInterno2] [varchar](255) NOT NULL,
	[tipoCampo] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_CamposExtras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tabla] ASC,
	[campolibre] ASC,
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_CargosDtos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_CargosDtos_Equivalencias](
	[empresa] [int] NOT NULL,
	[codigo] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[ajustarBase] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_CargosDtos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codigo] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_Descuentos_CargosDtos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_Descuentos_CargosDtos_Equivalencias](
	[empresa] [int] NOT NULL,
	[coddto] [int] NOT NULL,
	[codigo] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_Descuentos_CargosDtos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[coddto] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_Descuentos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_Descuentos_Equivalencias](
	[empresa] [int] NOT NULL,
	[idmotivodto] [int] NOT NULL,
	[codigo] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_Descuentos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idmotivodto] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_MediosPago_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_MediosPago_Equivalencias](
	[empresa] [int] NOT NULL,
	[codformapago] [varchar](10) NOT NULL,
	[mediopago] [varchar](10) NOT NULL,
	[metodopago] [varchar](2) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_MediosPago_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codformapago] ASC,
	[mediopago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_Series] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_Series](
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[fechaInicial] [datetime] NULL,
	[habilitado] [smallint] NOT NULL,
	[desdeServicio] [smallint] NOT NULL,
	[fechahora] [datetime] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_Series] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_TiposDocumento] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposDocumento](
	[tipodocumento] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipodocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_TiposDocumento_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposDocumento_Equivalencias](
	[empresa] [int] NOT NULL,
	[tipodoc] [int] NOT NULL,
	[tipoDocumento] [varchar](10) NOT NULL,
	[tipoOperacion] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_TiposDocumento_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipodoc] ASC,
	[tipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_TiposImpuesto_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposImpuesto_Equivalencias](
	[empresa] [int] NOT NULL,
	[tipoimpuesto] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_TiposImpuesto_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipoimpuesto] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Compras_TiposRet_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposRet_Equivalencias](
	[empresa] [int] NOT NULL,
	[tiporetencion] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Compras_TiposRet_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tiporetencion] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ComprasGeneradas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[estado] [smallint] NOT NULL,
	[xml_enviado] [varchar](max) NULL,
	[respuesta] [varchar](max) NULL,
	[respuesta_cufe] [varchar](255) NULL,
	[respuesta_xml] [varchar](max) NULL,
	[estado_pdf] [smallint] NOT NULL,
	[respuesta_pdf] [varbinary](max) NULL,
	[numserie_albaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[n_albaran] [char](1) NOT NULL,
	[esdevolucion] [char](1) NULL,
	[fechaEmision] [datetime] NULL,
	[fechaRespuesta] [datetime] NULL,
	[respuesta_esValidoDian] [smallint] NULL,
	[respuesta_tipoCufe] [varchar](20) NULL,
	[respuesta_qr] [varchar](max) NULL,
	[respuesta_nombre] [varchar](255) NULL,
	[respuesta_mensajesValidacion] [varchar](max) NULL,
	[respuesta_reglasNotificacionDian] [varchar](max) NULL,
	[respuesta_reglasValidacionDian] [varchar](max) NULL,
	[estadoAdjuntos] [smallint] NOT NULL,
	[adjuntos] [varchar](4000) NULL,
	[exportado] [smallint] NOT NULL,
	[auditado] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_ComprasGeneradas] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ComprasGeneradas_Consultas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas_Consultas](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[acuseComentario] [varchar](255) NULL,
	[acuseStatus] [varchar](10) NULL,
	[acuseRespuesta] [varchar](10) NULL,
	[codigo] [int] NULL,
	[cufe] [varchar](255) NULL,
	[estatusDocumento] [int] NULL,
	[fechaDocumento] [varchar](20) NULL,
	[mensaje] [varchar](255) NULL,
	[mensajeDocumento] [varchar](255) NULL,
	[resultado] [varchar](255) NULL,
	[aceptacionFisica] [smallint] NULL,
	[descripcionEstatusDocumento] [varchar](255) NULL,
	[entregaMetodoDian] [varchar](255) NULL,
	[esValidoDian] [smallint] NULL,
	[reglasValidacionDian] [varchar](max) NULL,
	[trackId] [varchar](255) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_ComprasGeneradas_Consultas] PRIMARY KEY CLUSTERED 
(
	[idregistro] ASC,
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_CorreoAlterno] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_CorreoAlterno](
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[autorizado] [smallint] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_CorreoAlterno] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Descuentos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Descuentos](
	[codigo] [varchar](2) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Descuentos_CargosDtos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Descuentos_CargosDtos_Equivalencias](
	[empresa] [int] NOT NULL,
	[coddto] [int] NOT NULL,
	[codigo] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Descuentos_CargosDtos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[coddto] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Descuentos_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Descuentos_Equivalencias](
	[empresa] [int] NOT NULL,
	[idmotivodto] [int] NOT NULL,
	[codigo] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Descuentos_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[idmotivodto] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Estados] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Estados](
	[codigo] [int] NOT NULL,
	[resultado] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Facturas_Eliminar] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Facturas_Eliminar](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[caja] [varchar](10) NOT NULL,
	[fo] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [char](1) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Facturas_Eliminar] PRIMARY KEY CLUSTERED 
(
	[idregistro] ASC,
	[empresa] ASC,
	[caja] ASC,
	[fo] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_FacturasGeneradas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[estado] [smallint] NOT NULL,
	[xml_enviado] [varchar](max) NULL,
	[respuesta] [varchar](max) NULL,
	[respuesta_cufe] [varchar](255) NULL,
	[respuesta_xml] [varchar](max) NULL,
	[estado_pdf] [smallint] NOT NULL,
	[respuesta_pdf] [varbinary](max) NULL,
	[numserie_albaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[n_albaran] [char](1) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[esdevolucion] [char](1) NULL,
	[fechaEmision] [datetime] NULL,
	[fechaRespuesta] [datetime] NULL,
	[esVP] [smallint] NULL,
	[respuesta_esValidoDian] [smallint] NULL,
	[respuesta_tipoCufe] [varchar](20) NULL,
	[respuesta_qr] [varchar](max) NULL,
	[respuesta_nombre] [varchar](255) NULL,
	[respuesta_mensajesValidacion] [varchar](max) NULL,
	[respuesta_reglasNotificacionDian] [varchar](max) NULL,
	[respuesta_reglasValidacionDian] [varchar](max) NULL,
	[exportado] [smallint] NULL,
	[auditado] [smallint] NULL,
	[estadoAdjuntos] [smallint] NULL,
	[adjuntos] [varchar](4000) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_FacturasGeneradas2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_FacturasGeneradas_Consultas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas_Consultas](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[acuseComentario] [varchar](255) NULL,
	[acuseStatus] [varchar](10) NULL,
	[acuseRespuesta] [varchar](10) NULL,
	[codigo] [int] NULL,
	[cufe] [varchar](255) NULL,
	[estatusDocumento] [int] NULL,
	[fechaDocumento] [varchar](20) NULL,
	[mensaje] [varchar](255) NULL,
	[mensajeDocumento] [varchar](255) NULL,
	[resultado] [varchar](255) NULL,
	[fechahora] [datetime] NOT NULL,
	[aceptacionFisica] [smallint] NULL,
	[descripcionEstatusDocumento] [varchar](255) NULL,
	[entregaMetodoDian] [varchar](255) NULL,
	[esValidoDian] [smallint] NULL,
	[reglasValidacionDian] [varchar](max) NULL,
	[trackId] [varchar](255) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_FacturasGeneradas_Consultas2] PRIMARY KEY CLUSTERED 
(
	[idregistro] ASC,
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_MediosPago] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_MediosPago](
	[mediopago] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[mediopago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_MediosPago_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_MediosPago_Equivalencias](
	[empresa] [int] NOT NULL,
	[codformapago] [varchar](10) NOT NULL,
	[mediopago] [varchar](10) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[metodopago] [varchar](2) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_MediosPago_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codformapago] ASC,
	[mediopago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_MediosPago_ICG_Negativos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_MediosPago_ICG_Negativos](
	[codformapago] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codformapago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_MetodosPago] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_MetodosPago](
	[metodopago] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[metodopago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Municipios] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Municipios](
	[codigo] [varchar](5) NULL,
	[departamento] [varchar](60) NULL,
	[municipio] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Paises] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Paises](
	[codigo] [varchar](3) NOT NULL,
	[alfa2] [varchar](2) NOT NULL,
	[alfa3] [varchar](3) NOT NULL,
	[nombre] [varchar](100) NULL,
	[nombreISO] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Parametros] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Parametros](
	[IDREGISTRO] [int] NOT NULL,
	[DESCRIPCION] [varchar](255) NOT NULL,
	[VALOR] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDREGISTRO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Reglas] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Reglas](
	[codigo] [varchar](20) NOT NULL,
	[tipo] [smallint] NOT NULL,
	[descripcion] [varchar](4000) NULL,
	[fechahora] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ResponsabilidadesFiscales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ResponsabilidadesFiscales](
	[codigo] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_Series] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_Series](
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[habilitado] [smallint] NOT NULL,
	[fechaInicial] [datetime] NULL,
	[esContingencia] [smallint] NULL,
	[fechahora] [datetime] NULL,
	[desdeServicio] [smallint] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_Series2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TEF] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TEF](
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[caja] [varchar](10) NOT NULL,
	[guardandoTEF] [smallint] NOT NULL,
	[posicion] [int] NULL,
	[codformapago] [varchar](6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TEF] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposDocumento] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposDocumento](
	[tipodocumento] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipodocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposDocumento_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposDocumento_Equivalencias](
	[empresa] [int] NOT NULL,
	[tipodoc] [int] NOT NULL,
	[tipodocumento] [varchar](10) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[tipoOperacion] [varchar](2) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TiposDocumento_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipodoc] ASC,
	[tipodocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposImpuesto] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposImpuesto](
	[impuesto] [varchar](2) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
	[esTipoBolsa] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposImpuesto_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposImpuesto_Equivalencias](
	[empresa] [int] NOT NULL,
	[tipoimpuesto] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TiposImpuesto_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tipoimpuesto] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposOperacion] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposOperacion](
	[tipoOperacion] [varchar](2) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipoOperacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposRegimen] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposRegimen](
	[regimen] [varchar](4) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TiposRegimen] PRIMARY KEY CLUSTERED 
(
	[regimen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposRegimen_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposRegimen_Equivalencias](
	[empresa] [int] NOT NULL,
	[codregimen] [char](1) NOT NULL,
	[regimen] [varchar](4) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TiposRegimen_Equivalencias2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[codregimen] ASC,
	[regimen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TiposRet_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TiposRet_Equivalencias](
	[empresa] [int] NOT NULL,
	[tiporetencion] [int] NOT NULL,
	[impuesto] [varchar](2) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TiposRet_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[tiporetencion] ASC,
	[impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_TIQUETSLIN] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_TIQUETSLIN](
	[empresa] [int] NOT NULL,
	[fo] [smallint] NOT NULL,
	[serie] [nvarchar](4) NOT NULL,
	[numero] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlinea] [int] NOT NULL,
	[codarticulo] [int] NULL,
	[descripcion] [nvarchar](45) NULL,
	[coste] [float] NULL,
	[unidades] [float] NULL,
	[precio] [float] NULL,
	[precioiva] [float] NULL,
	[preciodefecto] [float] NULL,
	[codvendedor] [int] NULL,
	[codformato] [int] NULL,
	[codmacro] [int] NULL,
	[tipo] [nvarchar](2) NULL,
	[tipoiva] [smallint] NULL,
	[dto] [float] NULL,
	[referencia] [nvarchar](15) NULL,
	[hora] [datetime] NULL,
	[costeiva] [float] NULL,
	[total] [float] NULL,
	[iva] [float] NULL,
	[req] [float] NULL,
	[sordertiquet] [nvarchar](4) NULL,
	[nordertiquet] [int] NULL,
	[abonode_fo] [smallint] NULL,
	[abonode_serie] [nvarchar](4) NULL,
	[abonode_numero] [int] NULL,
	[abonode_n] [nchar](1) NULL,
	[detallemodif] [bit] NULL,
	[detalledenumlinea] [int] NULL,
	[codtarifa] [int] NULL,
	[idmotivodto] [int] NULL,
	[dtoantespromocion] [float] NULL,
	[tarifaantespromocion] [int] NULL,
	[idpromocion] [int] NULL,
	[importepromocion] [float] NULL,
	[importepromocioniva] [float] NULL,
	[importeantespromocion] [float] NULL,
	[importeantespromocioniva] [float] NULL,
	[abonode_numlinea] [int] NULL,
	[tipodelivery] [int] NULL,
	[idmotivoabono] [int] NULL,
	[idlineaminuta] [bigint] NULL,
	[regalomenu] [bit] NULL,
	[seriales] [nvarchar](4000) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_TIQUETSLIN] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[fo] ASC,
	[serie] ASC,
	[numero] ASC,
	[n] ASC,
	[numlinea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_UnidadesMedida] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_UnidadesMedida](
	[codigo] [varchar](10) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
	[fechahora] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_UnidadesMedida_Equivalencias] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_UnidadesMedida_Equivalencias](
	[empresa] [int] NOT NULL,
	[unidadMedida] [varchar](10) NOT NULL,
	[unidadMedidaFE] [varchar](10) NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE_UnidadesMedida_Equivalencias] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[unidadMedida] ASC,
	[unidadMedidaFE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE_ZonasPostales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE_ZonasPostales](
	[municipio] [varchar](5) NOT NULL,
	[zonaPostal] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE0_Compra] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE0_Compra](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfacresol] [int] NOT NULL,
	[consecutivodocumento] [varchar](20) NOT NULL,
	[consecutivodocumentomodificado] [varchar](20) NOT NULL,
	[estadopago] [smallint] NOT NULL,
	[fechaemision] [varchar](19) NOT NULL,
	[fechaemisiondocumentomodificado] [varchar](19) NOT NULL,
	[fechavencimiento] [varchar](19) NOT NULL,
	[icoterms] [varchar](3) NOT NULL,
	[importetotal] [decimal](21, 6) NOT NULL,
	[informacionadicional] [varchar](100) NOT NULL,
	[mediopago] [varchar](4) NULL,
	[moneda] [varchar](3) NOT NULL,
	[motivonota] [smallint] NOT NULL,
	[propina] [decimal](21, 6) NOT NULL,
	[rangonumeracion] [varchar](21) NOT NULL,
	[tipodocumento] [varchar](2) NOT NULL,
	[totaldescuentos] [decimal](21, 6) NOT NULL,
	[totalsinimpuestos] [decimal](21, 6) NOT NULL,
	[uuiddocumentomodificado] [varchar](200) NULL,
	[prefijo] [varchar](20) NULL,
	[numeroinicial] [int] NULL,
	[numerofinal] [int] NULL,
	[factormoneda] [decimal](21, 6) NULL,
	[monedaprincipal] [varchar](3) NULL,
	[fechaInicioPeriodoFacturacion] [varchar](19) NULL,
	[fechaFinPeriodoFacturacion] [varchar](19) NULL,
	[redondeoAplicado] [decimal](21, 6) NULL,
	[tipoOperacion] [varchar](2) NULL,
	[totalAnticipos] [decimal](21, 6) NULL,
	[totalBaseImponible] [decimal](21, 6) NULL,
	[totalBrutoConImpuesto] [decimal](21, 6) NULL,
	[totalCargosAplicados] [decimal](21, 6) NULL,
	[totalMonto] [decimal](21, 6) NULL,
	[totalProductos] [int] NULL,
	[cantidadDecimales] [int] NULL,
	[ref_codigoInterno] [char](1) NULL,
	[ref_descripcion] [varchar](500) NULL,
	[ref_tipoCufe] [varchar](11) NULL,
	[oc_numeroOrden] [varchar](20) NULL,
	[fechaDeTasaDeCambio] [varchar](10) NULL,
	[exportado] [smallint] NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE0_Compra] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE0_Factura] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE0_Factura](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numfacresol] [int] NOT NULL,
	[consecutivodocumento] [varchar](20) NOT NULL,
	[consecutivodocumentomodificado] [varchar](20) NOT NULL,
	[estadopago] [smallint] NOT NULL,
	[fechaemision] [varchar](19) NOT NULL,
	[fechaemisiondocumentomodificado] [varchar](19) NOT NULL,
	[fechavencimiento] [varchar](19) NOT NULL,
	[icoterms] [varchar](3) NOT NULL,
	[importetotal] [decimal](21, 6) NOT NULL,
	[informacionadicional] [varchar](100) NOT NULL,
	[mediopago] [varchar](4) NULL,
	[moneda] [varchar](3) NOT NULL,
	[motivonota] [smallint] NOT NULL,
	[propina] [decimal](21, 6) NOT NULL,
	[rangonumeracion] [varchar](21) NOT NULL,
	[tipodocumento] [varchar](2) NOT NULL,
	[totaldescuentos] [decimal](21, 6) NOT NULL,
	[totalsinimpuestos] [decimal](21, 6) NOT NULL,
	[uuiddocumentomodificado] [varchar](200) NULL,
	[prefijo] [varchar](20) NULL,
	[fechahora] [datetime] NOT NULL,
	[numeroinicial] [int] NULL,
	[numerofinal] [int] NULL,
	[factormoneda] [decimal](18, 2) NULL,
	[monedaprincipal] [varchar](3) NULL,
	[fechaInicioPeriodoFacturacion] [varchar](19) NULL,
	[fechaFinPeriodoFacturacion] [varchar](19) NULL,
	[redondeoAplicado] [decimal](18, 3) NULL,
	[tipoOperacion] [varchar](2) NULL,
	[totalAnticipos] [decimal](21, 6) NULL,
	[totalBaseImponible] [decimal](21, 6) NULL,
	[totalBrutoConImpuesto] [decimal](21, 6) NULL,
	[totalCargosAplicados] [decimal](21, 6) NULL,
	[totalMonto] [decimal](21, 6) NULL,
	[totalProductos] [int] NULL,
	[cantidadDecimales] [int] NULL,
	[ref_codigoInterno] [char](1) NULL,
	[ref_descripcion] [varchar](500) NULL,
	[ref_tipoCufe] [varchar](11) NULL,
	[oc_numeroOrden] [varchar](20) NULL,
	[fechaDeTasaDeCambio] [varchar](10) NULL,
	[exportado] [smallint] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE0_Factura3] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE1_CompraProveedor] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE1_CompraProveedor](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[ciudad] [varchar](100) NOT NULL,
	[departamento] [varchar](100) NOT NULL,
	[direccion] [varchar](100) NOT NULL,
	[email] [varchar](200) NOT NULL,
	[nombrerazonsocial] [varchar](450) NOT NULL,
	[notificar] [varchar](2) NOT NULL,
	[numerodocumento] [varchar](13) NOT NULL,
	[pais] [varchar](50) NOT NULL,
	[referencia2] [varchar](50) NOT NULL,
	[regimen] [varchar](4) NOT NULL,
	[segundonombre] [varchar](50) NOT NULL,
	[subdivision] [varchar](50) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[tipoidentificacion] [varchar](2) NOT NULL,
	[tipopersona] [varchar](1) NOT NULL,
	[codigoImpuesto] [varchar](2) NULL,
	[codigoDepartamento] [varchar](10) NULL,
	[municipio] [varchar](50) NULL,
	[lenguaje] [varchar](2) NULL,
	[zonaPostal] [varchar](10) NULL,
	[numeroIdentificacionDV] [varchar](2) NULL,
	[responsabilidadesFiscales] [varchar](255) NULL,
	[nombreComercial] [varchar](450) NULL,
	[codproveedor] [int] NULL,
	[procedencia] [varchar](2) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE1_CompraProveedor] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numalbaran] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE1_FacturaCliente] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE1_FacturaCliente](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
	[ciudad] [varchar](100) NULL,
	[departamento] [varchar](100) NULL,
	[direccion] [varchar](100) NULL,
	[email] [varchar](200) NOT NULL,
	[nombrerazonsocial] [varchar](450) NULL,
	[notificar] [varchar](2) NOT NULL,
	[numerodocumento] [varchar](13) NOT NULL,
	[pais] [varchar](50) NOT NULL,
	[referencia2] [varchar](50) NOT NULL,
	[regimen] [varchar](4) NULL,
	[segundonombre] [varchar](50) NOT NULL,
	[subdivision] [varchar](50) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[tipoidentificacion] [varchar](2) NOT NULL,
	[tipopersona] [varchar](1) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[codigoImpuesto] [varchar](2) NULL,
	[codigoDepartamento] [varchar](10) NULL,
	[lenguaje] [varchar](2) NULL,
	[municipio] [varchar](50) NULL,
	[zonaPostal] [varchar](10) NULL,
	[numeroIdentificacionDV] [varchar](2) NULL,
	[responsabilidadesFiscales] [varchar](255) NULL,
	[nombreComercial] [varchar](450) NULL,
	[codcliente] [int] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE1_FacturaCliente3] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numalbaran] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE10_CompraMediosPago] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE10_CompraMediosPago](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[codformapago] [varchar](6) NOT NULL,
	[fechaDeVencimiento] [varchar](19) NULL,
	[medioPago] [varchar](10) NULL,
	[metodoDePago] [varchar](2) NULL,
	[numeroDeReferencia] [varchar](200) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE10_CompraMediosPago] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codformapago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE10_FacturaMediosPago] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE10_FacturaMediosPago](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[codformapago] [varchar](6) NOT NULL,
	[fechaDeVencimiento] [varchar](19) NULL,
	[medioPago] [varchar](10) NULL,
	[metodoDePago] [varchar](2) NULL,
	[numeroDeReferencia] [varchar](200) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE10_FacturaMediosPago] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codformapago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE11_CompraDescuentos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE11_CompraDescuentos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[numalbaran] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[secuencia] [int] NOT NULL,
	[codigo] [varchar](2) NULL,
	[descripcion] [varchar](255) NULL,
	[indicador] [smallint] NULL,
	[monto] [decimal](21, 6) NULL,
	[montoBase] [decimal](21, 6) NULL,
	[porcentaje] [decimal](18, 2) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE11_CompraDescuentos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE11_FacturaDescuentos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE11_FacturaDescuentos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[secuencia] [int] NOT NULL,
	[codigo] [varchar](2) NULL,
	[descripcion] [varchar](255) NULL,
	[indicador] [smallint] NULL,
	[monto] [decimal](21, 6) NULL,
	[montoBase] [decimal](21, 6) NULL,
	[porcentaje] [decimal](18, 2) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE11_FacturaDescuentos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE12_FacturaAnticipos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE12_FacturaAnticipos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[fechaDeRecibido] [varchar](10) NULL,
	[fechaDePago] [varchar](10) NULL,
	[horaDePago] [varchar](10) NULL,
	[id] [varchar](150) NULL,
	[instrucciones] [varchar](max) NULL,
	[montoPagado] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE12_FacturaAnticipos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE13_CompraImpuestos_Validacion] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE13_CompraImpuestos_Validacion](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[totalImpuestos] [decimal](21, 6) NOT NULL,
	[totalImpuestosDetalle] [decimal](21, 6) NOT NULL,
	[totIVA] [decimal](21, 6) NOT NULL,
	[totalImpuestosDetalle2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE13_CompraImpuestos_Validacion] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE13_FacturaImpuestos_Validacion] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE13_FacturaImpuestos_Validacion](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[totalImpuestos] [decimal](21, 6) NOT NULL,
	[totalImpuestosDetalle] [decimal](21, 6) NOT NULL,
	[totIVA] [decimal](21, 6) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[totalImpuestosDetalle2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE13_FacturaImpuestos_Validacion] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE14_Adjuntos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE14_Adjuntos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[terminal] [varchar](255) NOT NULL,
	[prefijo] [varchar](20) NOT NULL,
	[consecutivo] [varchar](20) NOT NULL,
	[estado] [smallint] NOT NULL,
	[respuesta] [varchar](max) NULL,
	[email] [varchar](4000) NULL,
	[archivos] [varchar](max) NOT NULL,
	[respuesta_mensajesValidacion] [varchar](max) NULL,
	[fechahoraFinalizado] [datetime] NULL,
	[exportado] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE14_Adjuntos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE14_CompraAdjuntos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE14_CompraAdjuntos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[terminal] [varchar](255) NOT NULL,
	[prefijo] [varchar](20) NOT NULL,
	[consecutivo] [varchar](20) NOT NULL,
	[estado] [smallint] NOT NULL,
	[respuesta] [varchar](max) NULL,
	[email] [varchar](4000) NULL,
	[archivos] [varchar](max) NOT NULL,
	[respuesta_mensajesValidacion] [varchar](max) NULL,
	[fechahoraFinalizado] [datetime] NULL,
	[exportado] [smallint] NOT NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE14_CompraAdjuntos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE2_CompraDetalle] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE2_CompraDetalle](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numlin] [int] NOT NULL,
	[cantidadunidades] [varchar](20) NOT NULL,
	[codigoproducto] [varchar](21) NOT NULL,
	[descripcion] [varchar](300) NOT NULL,
	[descripcion2] [varchar](300) NOT NULL,
	[descripcion3] [varchar](300) NOT NULL,
	[descuento] [decimal](21, 6) NOT NULL,
	[detalleadicionalnombre] [varchar](10) NOT NULL,
	[detalleadicionalvalor] [varchar](10) NOT NULL,
	[preciototal] [decimal](21, 6) NOT NULL,
	[preciototalsinimpuestos] [decimal](21, 6) NOT NULL,
	[precioventaunitario] [decimal](21, 6) NOT NULL,
	[seriales] [varchar](4000) NULL,
	[unidadmedida] [varchar](10) NOT NULL,
	[cantidadReal] [decimal](21, 6) NULL,
	[cantidadRealUnidadMedida] [varchar](6) NULL,
	[estandarCodigo] [varchar](10) NULL,
	[estandarCodigoProducto] [varchar](50) NULL,
	[marca] [varchar](100) NULL,
	[modelo] [varchar](100) NULL,
	[muestraGratis] [smallint] NULL,
	[precioReferencia] [decimal](21, 6) NULL,
	[codigoTipoPrecio] [varchar](2) NULL,
	[nota] [varchar](500) NULL,
	[descuento2] [decimal](21, 6) NULL,
	[preciototal2] [decimal](21, 6) NULL,
	[preciototalsinimpuestos2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE2_CompraDetalle] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE2_FacturaDetalle] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE2_FacturaDetalle](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[cantidadunidades] [varchar](20) NOT NULL,
	[codigoproducto] [varchar](21) NOT NULL,
	[descripcion] [varchar](300) NOT NULL,
	[descuento] [decimal](21, 6) NOT NULL,
	[detalleadicionalnombre] [varchar](10) NOT NULL,
	[detalleadicionalvalor] [varchar](10) NOT NULL,
	[preciototal] [decimal](21, 6) NOT NULL,
	[preciototalsinimpuestos] [decimal](21, 6) NOT NULL,
	[precioventaunitario] [decimal](21, 6) NOT NULL,
	[seriales] [varchar](4000) NULL,
	[unidadmedida] [varchar](10) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[cantidadReal] [decimal](21, 6) NULL,
	[cantidadRealUnidadMedida] [varchar](6) NULL,
	[estandarCodigo] [varchar](10) NULL,
	[estandarCodigoProducto] [varchar](50) NULL,
	[marca] [varchar](100) NULL,
	[modelo] [varchar](100) NULL,
	[muestraGratis] [smallint] NULL,
	[precioReferencia] [decimal](21, 6) NULL,
	[codigoTipoPrecio] [varchar](2) NULL,
	[nota] [varchar](500) NULL,
	[descuento2] [decimal](21, 6) NULL,
	[preciototal2] [decimal](21, 6) NULL,
	[preciototalsinimpuestos2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE2_FacturaDetalle3] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numlin] [int] NOT NULL,
	[baseimponibletotalimp] [decimal](21, 6) NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[controlinterno] [varchar](10) NOT NULL,
	[porcentajetotalimp] [decimal](5, 2) NOT NULL,
	[valortotalimp] [decimal](21, 6) NOT NULL,
	[unidadMedida] [varchar](6) NULL,
	[unidadMedidaTributo] [decimal](21, 6) NULL,
	[valorTributoUnidad] [decimal](21, 6) NULL,
	[baseimponibletotalimp2] [decimal](21, 6) NULL,
	[valortotalimp2] [decimal](21, 6) NULL,
	[unidadMedidaTributo2] [decimal](21, 6) NULL,
	[valorTributoUnidad2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE3_CompraDetalleImpuestos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[baseimponibletotalimp] [decimal](21, 6) NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[controlinterno] [varchar](10) NOT NULL,
	[porcentajetotalimp] [decimal](5, 2) NOT NULL,
	[valortotalimp] [decimal](21, 6) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[unidadMedida] [varchar](6) NULL,
	[unidadMedidaTributo] [decimal](21, 6) NULL,
	[valorTributoUnidad] [decimal](21, 6) NULL,
	[baseimponibletotalimp2] [decimal](21, 6) NULL,
	[valortotalimp2] [decimal](21, 6) NULL,
	[unidadMedidaTributo2] [decimal](21, 6) NULL,
	[valorTributoUnidad2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE3_FacturaDetalleImpuestos4] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE4_CompraImpuestos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE4_CompraImpuestos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[baseimponibletotalimp] [decimal](21, 6) NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[controlinterno] [varchar](10) NULL,
	[porcentajetotalimp] [decimal](6, 3) NOT NULL,
	[valortotalimp] [decimal](21, 6) NOT NULL,
	[esRetencion] [smallint] NOT NULL,
	[unidadMedidaTributo] [decimal](21, 6) NULL,
	[valorTributoUnidad] [decimal](21, 6) NULL,
	[baseimponibletotalimp2] [decimal](21, 6) NULL,
	[valortotalimp2] [decimal](21, 6) NULL,
	[unidadMedidaTributo2] [decimal](21, 6) NULL,
	[valorTributoUnidad2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE4_CompraImpuestos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codigototalimp] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE4_FacturaImpuestos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE4_FacturaImpuestos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[baseimponibletotalimp] [decimal](21, 6) NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[controlinterno] [varchar](10) NULL,
	[porcentajetotalimp] [decimal](6, 3) NOT NULL,
	[valortotalimp] [decimal](21, 6) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[esRetencion] [smallint] NULL,
	[unidadMedidaTributo] [decimal](21, 6) NULL,
	[valorTributoUnidad] [decimal](21, 6) NULL,
	[baseimponibletotalimp2] [decimal](21, 6) NULL,
	[valortotalimp2] [decimal](21, 6) NULL,
	[unidadMedidaTributo2] [decimal](21, 6) NULL,
	[valorTributoUnidad2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE4_FacturaImpuesto3] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codigototalimp] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE5_CompraExtras] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE5_CompraExtras](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[valor] [varchar](200) NULL,
	[pdf] [smallint] NOT NULL,
	[xml] [smallint] NOT NULL,
	[controlinterno1] [varchar](255) NULL,
	[controlinterno2] [varchar](255) NULL,
	[tipoCampo] [smallint] NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE5_CompraExtras] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE5_FacturaExtras] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE5_FacturaExtras](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[valor] [varchar](200) NULL,
	[pdf] [smallint] NOT NULL,
	[xml] [smallint] NOT NULL,
	[controlinterno1] [varchar](255) NULL,
	[controlinterno2] [varchar](255) NULL,
	[fechahora] [datetime] NOT NULL,
	[tipoCampo] [smallint] NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE5_FacturaExtras2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE6_CompraDetalle_Comentarios] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE6_CompraDetalle_Comentarios](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numlin] [int] NOT NULL,
	[descripcion] [varchar](100) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE6_CompraDetalle_Comentarios] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE6_FacturaDetalle_Comentarios] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE6_FacturaDetalle_Comentarios](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[descripcion] [varchar](100) NULL,
	[fechahora] [datetime] NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE6_FacturaDetalle_Comentarios2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE7_CompraDetalle_Descuentos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE7_CompraDetalle_Descuentos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numlin] [int] NOT NULL,
	[secuencia] [int] NOT NULL,
	[codigo] [varchar](2) NULL,
	[descripcion] [varchar](255) NULL,
	[indicador] [smallint] NULL,
	[monto] [decimal](21, 6) NULL,
	[montoBase] [decimal](21, 6) NULL,
	[porcentaje] [decimal](21, 6) NULL,
	[monto2] [decimal](21, 6) NULL,
	[montoBase2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE7_CompraDetalle_Descuentos] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE7_FacturaDetalle_Descuentos] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE7_FacturaDetalle_Descuentos](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[secuencia] [int] NOT NULL,
	[codigo] [varchar](2) NULL,
	[descripcion] [varchar](255) NULL,
	[indicador] [smallint] NULL,
	[monto] [decimal](21, 6) NULL,
	[montoBase] [decimal](21, 6) NULL,
	[porcentaje] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[monto2] [decimal](21, 6) NULL,
	[montoBase2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE7_FacturaDetalle_Descuentos2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[secuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE8_CompraDetalleImpuestos_Totales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE8_CompraDetalleImpuestos_Totales](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numlin] [int] NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[montototal] [decimal](21, 6) NOT NULL,
	[montototal2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE8_CompraDetalleImpuestos_Totales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[codigototalimp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE8_FacturaDetalleImpuestos_Totales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE8_FacturaDetalleImpuestos_Totales](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numlin] [int] NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[montototal] [decimal](21, 6) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[numserieAlbaran] [varchar](4) NOT NULL,
	[montototal2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE8_FacturaDetalleImpuestos_Totales2] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[numserieAlbaran] ASC,
	[numalbaran] ASC,
	[n] ASC,
	[numlin] ASC,
	[codigototalimp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE9_CompraImpuestos_Totales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE9_CompraImpuestos_Totales](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[montototal] [decimal](21, 6) NOT NULL,
	[esRetencion] [smallint] NULL,
	[montototal2] [decimal](21, 6) NULL,
	[fechahora] [datetime] NOT NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE9_CompraImpuestos_Totales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codigototalimp] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ICGFE_TAB_FE9_FacturaImpuestos_Totales] Fecha de script: 07/08/2026 22:37:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICGFE_TAB_FE9_FacturaImpuestos_Totales](
	[idregistro] [bigint] IDENTITY(1,1) NOT NULL,
	[empresa] [int] NOT NULL,
	[numserie] [varchar](4) NOT NULL,
	[numalbaran] [int] NOT NULL,
	[numfac] [int] NOT NULL,
	[n] [nchar](1) NOT NULL,
	[codigototalimp] [varchar](2) NOT NULL,
	[montototal] [decimal](21, 6) NOT NULL,
	[fechahora] [datetime] NOT NULL,
	[esRetencion] [smallint] NULL,
	[montototal2] [decimal](21, 6) NULL,
 CONSTRAINT [PK_ICGFE_TAB_FE9_FacturaImpuestos_Totales] PRIMARY KEY CLUSTERED 
(
	[empresa] ASC,
	[numserie] ASC,
	[numfac] ASC,
	[n] ASC,
	[codigototalimp] ASC,
	[idregistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FLX_APP_Mensajes_T1] ADD  DEFAULT (@@spid) FOR [Proceso]
GO
ALTER TABLE [dbo].[FLX_Log] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[FLX_Log] ADD  DEFAULT (host_name()) FOR [Maquina]
GO
ALTER TABLE [dbo].[FLX_Log] ADD  DEFAULT (app_name()) FOR [Aplicacion]
GO
ALTER TABLE [dbo].[FLX_Log] ADD  DEFAULT (suser_name()) FOR [Usuario]
GO
ALTER TABLE [dbo].[FLX_Prm_Parametros] ADD  CONSTRAINT [DF_FLX_Prm_Parametros_SeleccionMultiple]  DEFAULT ((0)) FOR [SeleccionMultiple]
GO
ALTER TABLE [dbo].[FLX_Prm_Parametros] ADD  CONSTRAINT [DF_FLX_Prm_Parametros_TipoClave]  DEFAULT ((0)) FOR [TipoClave]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ALBCOMPRALIN] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ALBVENTALIN] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CamposExtras] ADD  DEFAULT ((0)) FOR [pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CamposExtras] ADD  DEFAULT ((0)) FOR [xml]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CamposExtras] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CamposExtras] ADD  DEFAULT ((0)) FOR [tipoCampo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CargosDtos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CargosDtos_Equivalencias] ADD  DEFAULT ((0)) FOR [ajustarBase]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CargosDtos_Equivalencias] ADD  DEFAULT ((0)) FOR [esNominal]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CamposExtras] ADD  DEFAULT ((0)) FOR [pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CamposExtras] ADD  DEFAULT ((0)) FOR [xml]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CamposExtras] ADD  DEFAULT ((0)) FOR [tipoCampo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CamposExtras] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CargosDtos_Equivalencias] ADD  DEFAULT ((0)) FOR [ajustarBase]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_CargosDtos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_Descuentos_CargosDtos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_Descuentos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_MediosPago_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_Series] ADD  DEFAULT ((0)) FOR [habilitado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_Series] ADD  DEFAULT ((0)) FOR [desdeServicio]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_Series] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposDocumento_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposImpuesto_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Compras_TiposRet_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ((0)) FOR [estado_pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ('F') FOR [esdevolucion]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ((0)) FOR [estadoAdjuntos]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT ((0)) FOR [auditado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas_Consultas] ADD  DEFAULT ((0)) FOR [aceptacionFisica]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_ComprasGeneradas_Consultas] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_CorreoAlterno] ADD  DEFAULT ((0)) FOR [autorizado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Descuentos_CargosDtos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Descuentos_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Estados] ADD  DEFAULT ((1)) FOR [resultado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Estados] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Facturas_Eliminar] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((0)) FOR [estado_pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((1)) FOR [esVP]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((0)) FOR [auditado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas] ADD  DEFAULT ((0)) FOR [estadoAdjuntos]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas_Consultas] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_FacturasGeneradas_Consultas] ADD  DEFAULT ((0)) FOR [aceptacionFisica]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_MediosPago_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Reglas] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Series] ADD  DEFAULT ((0)) FOR [habilitado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Series] ADD  DEFAULT ((0)) FOR [esContingencia]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Series] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_Series] ADD  DEFAULT ((0)) FOR [desdeServicio]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TiposDocumento_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TiposImpuesto] ADD  DEFAULT ((0)) FOR [esTipoBolsa]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TiposImpuesto_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TiposRegimen_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TiposRet_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_TIQUETSLIN] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_UnidadesMedida] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE_UnidadesMedida_Equivalencias] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Compra] ADD  DEFAULT ((0)) FOR [cantidadDecimales]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Compra] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Compra] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Factura] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Factura] ADD  DEFAULT ((0)) FOR [cantidadDecimales]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE0_Factura] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE1_CompraProveedor] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE1_FacturaCliente] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE10_CompraMediosPago] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE10_FacturaMediosPago] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE11_CompraDescuentos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE11_FacturaDescuentos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE12_FacturaAnticipos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE13_CompraImpuestos_Validacion] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE13_FacturaImpuestos_Validacion] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_Adjuntos] ADD  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_Adjuntos] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_Adjuntos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_CompraAdjuntos] ADD  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_CompraAdjuntos] ADD  DEFAULT ((0)) FOR [exportado]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE14_CompraAdjuntos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE2_CompraDetalle] ADD  DEFAULT ((0)) FOR [muestraGratis]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE2_CompraDetalle] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE2_FacturaDetalle] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE2_FacturaDetalle] ADD  DEFAULT ((0)) FOR [muestraGratis]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo2]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad2]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_CompraDetalleImpuestos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo2]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE3_FacturaDetalleImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad2]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_CompraImpuestos] ADD  DEFAULT ((0)) FOR [esRetencion]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_CompraImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_CompraImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_CompraImpuestos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_FacturaImpuestos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_FacturaImpuestos] ADD  DEFAULT ((0)) FOR [esRetencion]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_FacturaImpuestos] ADD  DEFAULT ((0)) FOR [unidadMedidaTributo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE4_FacturaImpuestos] ADD  DEFAULT ((0)) FOR [valorTributoUnidad]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_CompraExtras] ADD  DEFAULT ((0)) FOR [pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_CompraExtras] ADD  DEFAULT ((0)) FOR [xml]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_CompraExtras] ADD  DEFAULT ((0)) FOR [tipoCampo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_CompraExtras] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_FacturaExtras] ADD  DEFAULT ((0)) FOR [pdf]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_FacturaExtras] ADD  DEFAULT ((0)) FOR [xml]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_FacturaExtras] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE5_FacturaExtras] ADD  DEFAULT ((0)) FOR [tipoCampo]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE6_CompraDetalle_Comentarios] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE6_FacturaDetalle_Comentarios] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE7_CompraDetalle_Descuentos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE7_FacturaDetalle_Descuentos] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE8_CompraDetalleImpuestos_Totales] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE8_FacturaDetalleImpuestos_Totales] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE9_CompraImpuestos_Totales] ADD  DEFAULT ((0)) FOR [esRetencion]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE9_CompraImpuestos_Totales] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE9_FacturaImpuestos_Totales] ADD  DEFAULT (getdate()) FOR [fechahora]
GO
ALTER TABLE [dbo].[ICGFE_TAB_FE9_FacturaImpuestos_Totales] ADD  DEFAULT ((0)) FOR [esRetencion]
GO
