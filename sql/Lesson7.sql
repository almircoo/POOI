/*** GestiÛn de Datos ***/
Create Database Lesson7
go

use Lesson7
go

/**Crear tabla Federaciones*/
Create Table Federaciones
(
FECHA_CORTE				int,
ITEM								smallint,
ORGANI_DEPORTIVA	varchar(150),
RESOL_RENADE			varchar(100),
PARTIDA_ELEC_RENADE		varchar(100),
FECHA_INSC_RENADE			date
)
go

--Consultar
Select * from Federaciones
go

--Comando Bulk Insert (Carga Masiva) desde un flat file (.txt  -  .csv)
Bulk Insert Federaciones
from 'D:\Data\Federaciones.TXT'
with (
firstRow=2,
fieldTerminator=',',
rowTerminator='\n'
);
go

-----------------------------------------------------------------------------
--------------------------------------
/** Crear tabla ***/
Create Table AgendaCC
(
ITEM					int,
A—O						smallint,
MES						varchar(18),
FRECUENCIA		varchar(50),
ACTIVIDAD			varchar(50),
DESCRIPCION	varchar(50),
HORARIO			varchar(50),
MEDIO					varchar(150),
DIRECCION		varchar(150),
CANTIDADALUMNOS tinyint
)
GO

Select * from AgendaCC
go

-----------------------------
-------------------------------------------------------
/*** MERGE *******/
Select	ProductID		[IdProducto],
		ProductName		[Producto],
		C.CategoryName	[Categoria],
		P.UnitsInStock	[Stock],
		P.UnitPrice		[Precio] into Producto
from Northwind.dbo.Products as P Join Northwind.dbo.Categories as C
on P.CategoryID=C.CategoryID
Where ProductID<=15
go

------------------------------------
Select * from Producto
go
------------------------------------

Select	ProductID			[IdProducto],
		ProductName			[Producto],
		C.CategoryName		[Categoria],
		P.UnitsInStock		[Stock],
		P.UnitPrice*0.90	[Precio]	into ProductoPlan
from Northwind.dbo.Products P Join Northwind.dbo.Categories C
on P.CategoryID=C.CategoryID
Where ProductID between 10 and 25
go

----------------------------
Select * from ProductoPlan
go
---------------------------

/*** MERGE ***/
Merge into Producto as Destino
using ProductoPlan as Origen
on Destino.idProducto = Origen.IdProducto
when matched then update set Destino.precio=Origen.precio
when not matched then insert values (Origen.idProducto, Origen.producto,
  Origen.categoria, Origen.stock, Origen.precio);
go
