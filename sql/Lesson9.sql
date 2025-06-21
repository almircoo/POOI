/* Data for Querys */
use master
go

if db_id('Lesson9') is not null
	Drop Database Lesson9
go

Create Database Lesson9
go

Use Lesson9
go

Set Dateformat DMY
go

--Generando tabla y actualizando
Select	ProductID	[IdProducto],
		ProductName	[NomProducto],
		CategoryID	[idCategoria],
		SupplierID	[idProveedor],
		UnitsInStock [stockProducto],
		UnitPrice	[precioProducto] into Producto
From Northwind.dbo.Products 
go

--
Update Producto
set idCategoria=null
where idCategoria in (7,8)
go

--
Select * from Producto
go

--
Update Producto
set idProveedor=null
where idProveedor in (24,25,26,27)
go

--
Select	CategoryID	[IdCategoria],
		CategoryName [nomCategoria] into Categoria
from Northwind.dbo.Categories

--
Select	SupplierID	[IdProveedor],
		CompanyName	[nomProveedor],
		ContactName	[nomContacto],
		Address		[dirProveedor],
		City		[ciudadResidencia],
		Country		[paisResidencia],
		Phone		[telProveedor] into Proveedor
from Northwind.dbo.Suppliers
go

--
Select	EmployeeID	[IdVendedor],
		firstname + ' ' +LastName [nomVendedor],
		BirthDate [fechaNac],
		HireDate	[fechaIng],
		City		[CiudadResVen],
		Country		[paisResVen] into Vendedor
from Northwind.dbo.Employees
go

---
Select	CustomerID		[idCliente],
		CompanyName		[nomCliente],
		Address			[dirCliente],
		Country			[paiCliente] into Cliente
from Northwind.dbo.Customers
go

---
Select	ShipperID	[idTransporte],
		CompanyName	[nomTransporte],
		Phone		[telTransporte] into Transporte
from Northwind.dbo.Shippers 
go

---
Select	OrderID		[idPedido],
		OrderDate	[fecPedido],
		ShippedDate	[fecEnvio],
		CustomerID	[idCliente],
		EmployeeID	[idVendedor],
		ShipVia		[idTransporte] into Pedido
from Northwind.dbo.Orders
go

---
Select	OrderID		[idPedido],
		ProductID	[idProducto],
		Quantity	[cantidadPedida],
		UnitPrice	[precioVenta],
		Discount	[porcentajeDscto] into DetallePedido
from Northwind.dbo.[Order Details]
go

---------------------------------------------------------
Select * from sys.tables

Alter Table Producto
add Primary Key nonclustered (idProducto)
go

Alter Table Categoria
add Primary Key nonclustered (idCategoria)
go

Alter Table Proveedor
Add primary key nonclustered (idProveedor)
go

Alter Table Vendedor
Add primary key nonclustered (idVendedor)
go

Alter table Cliente
add primary key nonclustered (idCliente)
go

Alter Table Transporte
add primary key nonclustered (idTransporte)
go

Alter Table Pedido
add primary key nonclustered (idPedido)
go

Alter Table DetallePedido
add primary key nonclustered (idPedido, idProducto)
go

-------------------------
Alter Table Producto
add foreign key (idCategoria) references Categoria
go

Alter Table Producto
add foreign key (idProveedor) references Proveedor
go

Alter Table DetallePedido
Add foreign key (idPedido) references Pedido
go

Alter Table DetallePedido
Add foreign key (idProducto) references Producto
go

Alter Table Pedido
Add foreign Key (idVendedor) references Vendedor
go

Alter Table Pedido
Add foreign Key (idCliente) references Cliente
go

Alter Table Pedido
Add foreign Key (idTransporte) references Transporte
go


/** Programación con Transact SQL**/
Use Lesson9
go

Set Dateformat DMY
go

--Transact SQL
--Variables Globales 
Select	@@language		[Lenguaje del servidor],
		@@servicename	[Nombre del servicio],
		@@version		[Versión del motor de base de datos SQL Serve],
		@@max_connections [Nro Máximo de conecciones soportados por SQL Server]
go

--Varibles Locales (definidas por el usuario)
--Bloque anónimo
Begin
	Declare @v_nom varchar(50)
	Declare @v_fechaNac date, @v_sueldo smallmoney
	------
	Set @v_nom='Javier'
	Select @v_fechaNac='10/10/2007', @v_sueldo=3600
	------
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Nombre :'+@v_nom
	Print 'Fecha de Nacimiento: '+@v_fechaNac
	Print 'Sueldo: '+@v_Sueldo
End
go
------Bloque con error de tipo de datos ------------------------------
Begin
	Declare @v_nom varchar(50)
	Declare @v_fechaNac date, @v_sueldo smallmoney
	------
	Set @v_nom='Javier'
	Select @v_fechaNac='10/10/2007', @v_sueldo=3600
	------
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Nombre :'+@v_nom
	Print 'Fecha de Nacimiento: '+@v_fechaNac	--Error Tipo de Dato
	Print 'Sueldo: '+@v_Sueldo					--Error Tipo de Dato
End
go
------------Solución: Aplicar función de Conversión o formato-------------
Begin
	Declare @v_nom varchar(50)
	Declare @v_fechaNac date, @v_sueldo smallmoney
	------
	Set @v_nom='Javier'
	Select @v_fechaNac='10/10/2007', @v_sueldo=3600
	------
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Nombre :'+@v_nom
	Print 'Fecha de Nacimiento: '+ Cast (@v_fechaNac as varchar(18))
	Print 'Sueldo: '+ Convert (Varchar(18), @v_Sueldo,4)
End
go

--Bloque Aplicando Formato
Begin
	Declare @v_nom varchar(50)
	Declare @v_fechaNac date, @v_sueldo smallmoney
	------
	Set @v_nom='Javier'
	Select @v_fechaNac='10/10/2007', @v_sueldo=3600
	------
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Nombre :'+@v_nom
	Print 'Fecha de Nacimiento: '+Format(@v_fechaNac,'D','es-pe')
	Print 'Sueldo: '+Format(@v_Sueldo,'C','es-pe')
End
go

---Una Variable puede contener resultado de una consulta, si este devuelve solo un dato
Begin
	Declare @V_IdVendedor int =1
	Declare @v_nomVendedor varchar(max), @v_cantPedidos smallint
	Select @v_nomVendedor=nomVendedor from Vendedor where IdVendedor=@V_IdVendedor
	Select @v_cantPedidos=count(*) from Pedido where IdVendedor=@V_IdVendedor
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Vendedor :' +@v_nomVendedor
	Print 'Cantidad de Pedidos :' +cast(@v_cantPedidos as varchar(25))
End
go

------------------------------------------------------------------------------------------
--Estructura de constrol IF --------------------------------------------------------------
--Ejemplo para determinar el tipo de vendedor
Begin
	Declare @V_IdVendedor int =9
	Declare @v_nomVendedor varchar(max), @v_cantPedidos smallint, @v_tipoV varchar(max)
	Select @v_nomVendedor=nomVendedor from Vendedor where IdVendedor=@V_IdVendedor
	Select @v_cantPedidos=count(*) from Pedido where IdVendedor=@V_IdVendedor
	if @v_cantPedidos>100
		Set @v_tipoV='Vendedor Excelente'
	else if @v_cantPedidos<50
		Set @v_tipoV='Vendedor Regular'
	else 
		Set @v_tipoV='Vendedor Normal'
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Vendedor :' +@v_nomVendedor
	Print 'Cantidad de Pedidos :' +cast(@v_cantPedidos as varchar(25))
	Print 'Tipo Vendedor :'+@v_tipoV
End
go

---
--Estructura de constrol CASE --------------------------------------------------------------
--Ejemplo para determinar el tipo de vendedor
Begin
	Declare @V_IdVendedor int =9
	Declare @v_nomVendedor varchar(max), @v_cantPedidos smallint, @v_tipoV varchar(max)
	Select @v_nomVendedor=nomVendedor from Vendedor where IdVendedor=@V_IdVendedor
	Select @v_cantPedidos=count(*) from Pedido where IdVendedor=@V_IdVendedor
	Set @v_tipoV=	Case 
						when @v_cantPedidos>100 then 'Vendedor Excelente'
						when @v_cantPedidos<50 then 'Vendedor Regular'
					else 'Vendedor Normal'
					End
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	Print 'Vendedor :' +@v_nomVendedor
	Print 'Cantidad de Pedidos :' +cast(@v_cantPedidos as varchar(25))
	Print 'Tipo Vendedor :'+@v_tipoV
End
go

---

--Estructura de constrol WHILE --------------------------------------------------------------
--Ejemplo para determinar el tipo de vendedor
Begin

	Declare @V_IdVendedor int
	Set @V_IdVendedor=1
	Print Replicate ('=',50)
	Print space(20)+'Reporte de Datos'
	Print Replicate ('=',50)
	While @V_IdVendedor<=9
	Begin 
		Declare @v_nomVendedor varchar(max), @v_cantPedidos smallint, @v_tipoV varchar(max)
		Select @v_nomVendedor=nomVendedor from Vendedor where IdVendedor=@V_IdVendedor
		Select @v_cantPedidos=count(*) from Pedido where IdVendedor=@V_IdVendedor
		if @v_cantPedidos>100
			Set @v_tipoV='Vendedor Excelente'
		else if @v_cantPedidos<50
			Set @v_tipoV='Vendedor Regular'
		else 
			Set @v_tipoV='Vendedor Normal'
		Print 'Vendedor :' +@v_nomVendedor
		Print 'Cantidad de Pedidos :' +cast(@v_cantPedidos as varchar(25))
		Print 'Tipo Vendedor :'+@v_tipoV
		Set @V_IdVendedor=@v_IDVendedor + 1
		Print Replicate ('=',50)
	End
End
go

/*Sesion 09: Parte2 : Raiserror, Try/Catch , Transaction*/
Use Lesson9
go

/**Generación de Errores: RaisError**/
Begin
	Declare @v_cantidadPedida smallint=110
	If @v_cantidadPedida>100
		Raiserror('Cantidad Excede lo permitido..',10,1) --Error leve
	else
		Print 'Cantidad Correcta'
End
go

-------------------------------
Begin
	Declare @v_cantidadPedida smallint=110
	If @v_cantidadPedida>100
		Raiserror('Cantidad Excede lo permitido..',16,1) --Error Grave
	else
		Print 'Cantidad Correcta'
End
go

/**Excepcionar Errores: TRY/CATCH**/
Begin
	Declare @v_cantidadPedida smallint=110
	Begin Try
		If @v_cantidadPedida>100
			Raiserror('Cantidad Excede lo permitido..',16,1) --Error Grave
		else
			Print 'Cantidad Correcta'
	End Try
	Begin Catch
		Print Error_message()
	End Catch
End
go

/*** Transacciones : Transaction ***/
Create Table OperadoresLogisto
(
idOpe	int,
nomOpe	varchar(50),
distOpe	varchar(50),
busesOpe smallint
)
go
--Transacción: Implícita - Explícita
--Transacción implícita
Begin
	Declare @vidOpe		int			='101',
			@vnomOpe	varchar(50)	='Ransa S.A',
			@vdistOpe	varchar(50)	='Callao',
			@vbusesOpe	smallint	= '120'
	Insert OperadoresLogisto
	values (@vidOpe, @vnomOpe, @vdistOpe, @vbusesOpe)
End

Select * From OperadoresLogisto
go

--Transacción Explícita
Begin
	Begin Transaction T1
		Declare @vidOpe		int			='102',
				@vnomOpe	varchar(50)	='REFASA',
				@vdistOpe	varchar(50)	='RIMAC',
				@vbusesOpe	smallint	= '15'
		Insert OperadoresLogisto
		values (@vidOpe, @vnomOpe, @vdistOpe, @vbusesOpe)
		If @vdistOpe Not In ('Rimac','Callao','Cercado')
			Commit Tran T1
		Else
			RollBack Tran T1
End
go



Select * From OperadoresLogisto
go

----Transacción Explícita con RaisError y Try Catch
Begin
	Begin Try
	Begin Transaction T1
		Declare @vidOpe		int			='102',
				@vnomOpe	varchar(50)	='REFASA',
				@vdistOpe	varchar(50)	='RIMAC',
				@vbusesOpe	smallint	= '15'
		Insert OperadoresLogisto
		values (@vidOpe, @vnomOpe, @vdistOpe, @vbusesOpe)
		If @vdistOpe Not In ('Rimac','Callao','Cercado')
			Commit Tran T1
		Else
			RaisError('Distrito no permitido...!!',16,1)
	End Try
	Begin Catch
			Print error_message()
			RollBack Tran T1
	End Catch
End
go

-----
Select * From OperadoresLogisto
go

