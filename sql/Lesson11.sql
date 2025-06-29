/**Procedimientos Almacenados - Funciones definidas por el usuario**/
use Lesson9
go

If exists (Select * from sys.tables where name='Unidad')
	Drop Table Unidad
go

--Crear Tabla
Create Table Unidad
(
nroPlaca	char(6) not null,
marca		varchar(50),
añoFab		smallint,
costo		smallmoney,
constraint PKUnidad Primary key NonClustered (nroPlaca)
)
go

/**Crear un SP que registre unidad**/
Create or Alter Procedure uspRegistraUnidad
	@p_nroPlaca		char(6) ,
	@p_marca		varchar(50),
	@p_añoFab		smallint,
	@p_costo		smallmoney
As
Begin
	Insert Unidad
	Values 
	(@p_nroPlaca,@p_marca,@p_añoFab,@p_costo)
End
go

-----------------------------------------
/**Crear un sp que registre mediante una transacción explícita, nuevas unidades 
validando que no exista, caso contrario, genere un error leve. 
Deberá invocar al SP anterior.**/
Create or Alter Procedure uspRegistraUnidadTran
	@p_nroPlaca		char(6) ,
	@p_marca		varchar(50),
	@p_añoFab		smallint,
	@p_costo		smallmoney
As
Begin
	If Not Exists (Select * from Unidad where nroplaca=@p_nroPlaca)
		Begin
			Begin Tran Transaccion1
			Execute uspRegistraUnidad @p_nroPlaca,@p_marca,@p_añoFab,@p_costo
			Commit Tran Transaccion1
		End
	else	
		RaisError ('Nro de Placa de Unidad ya existe..',10,1)
End
go

/**Ejecutar **/
Execute uspRegistraUnidadTran 'ABA223','Toyota','2020','12500'
go

Select * from Unidad
go

Execute uspRegistraUnidadTran 'ABA223','Toyota','2020','12500'
go

/**Modificar el SP anterior para confirmar la transacción siempre y cuando
cumpla la RN (marca debe ser Toyota, Nissan, Mitsubishi o Suzuki), caso contrario, 
genere un error grave, controlado con try Catch, cancelando la transacción**/
Create or Alter Procedure uspRegistraUnidadTran
	@p_nroPlaca		char(6) ,
	@p_marca		varchar(50),
	@p_añoFab		smallint,
	@p_costo		smallmoney
As
Begin
	Begin Try
		If Not Exists (Select * from Unidad where nroplaca=@p_nroPlaca)
			Begin
				Begin Tran Transaccion1
				Execute uspRegistraUnidad @p_nroPlaca,@p_marca,@p_añoFab,@p_costo
				--------------------------------------------------
				If @p_marca in ('Toyota', 'Nissan', 'Mitsubishi', 'Suzuki')
					Commit Tran Transaccion1
				Else
					RaisError ('Marca No Permitida por la SUTRAN..',16,1)
				--------------------------------------------------
			End
		else	
			RaisError ('Nro de Placa de Unidad ya existe..',10,1)
	End Try
	Begin Catch
		Print Error_message()
		Rollback Transaction Transaccion1
	End Catch
End
go

------------------------------
--Ejecutar
Execute uspRegistraUnidadTran 'ABA223','Toyota','2020','12500'
go

Execute uspRegistraUnidadTran 'FAT221','Changan','2021','10500'
go

Select * from Unidad
go

Execute uspRegistraUnidadTran 'FAT221','Nissan','2021','10500'
go

/**Modificar el SP anterior para confirmar la transacción siempre y cuando
cumpla otra RN adicional(año de fabricación menor o igual a 5 años de antiguedad), caso contrario, 
genere un error grave, controlado con try Catch, cancelando la transacción**/
Create or Alter Procedure uspRegistraUnidadTran
	@p_nroPlaca		char(6) ,
	@p_marca		varchar(50),
	@p_añoFab		smallint,
	@p_costo		smallmoney
As
Begin
	Begin Try
		If Not Exists (Select * from Unidad where nroplaca=@p_nroPlaca)
			Begin
				Begin Tran Transaccion1
				Execute uspRegistraUnidad @p_nroPlaca,@p_marca,@p_añoFab,@p_costo
				--------------------------------------------------
				If @p_marca in ('Toyota', 'Nissan', 'Mitsubishi', 'Suzuki')
					Begin
						If (Year(getdate())-@p_añoFab)<=5
							Commit Tran Transaccion1
						Else
							RaisError ('Año no permitido por el MTC..',16,1)
					End
				Else
					RaisError ('Marca No Permitida por la SUTRAN..',16,1)
				--------------------------------------------------
			End
		else	
			RaisError ('Nro de Placa de Unidad ya existe..',10,1)
	End Try
	Begin Catch
		Print Error_message()
		Rollback Transaction Transaccion1
	End Catch
End
go

--Ejecutar
Execute uspRegistraUnidadTran 'ABA223','Toyota','2020','12500'
go

Execute uspRegistraUnidadTran 'PTP223','Ford','2020','12500'
go

Execute uspRegistraUnidadTran 'PTP223','Toyota','2019','12500'
go

Execute uspRegistraUnidadTran 'PTP223','Toyota','2022','12500'
go

Select * from Unidad
go

/********Ahora lo vas hacer *******/
Create Table Store
(
idStore char(5) not null,
nomStore varchar(50),
disStore varchar(50),
fraStore varchar(50),
Primary Key nonclustered (idStore)
)
go

/***Crear un SP que registre mediante una transacción explícita, nuevas tiendas 
validando que no exista, caso contrario, genere un error leve. 
La transacción se confirmará si cumple las RN:
01- El Distrito de la tienda debe ser La Molina, San Borja, San Miguel, Miraflores, Barranco, Surco, Los Olivos.
02- La Franquicia de la tienda debe ser Tambo, Oxxo, Listo, RepShop, Bembos
En caso no se cumpla las RN deberá generar un error grave por cada incumplimiento, controlado por Try Catch, 
Cancelando la Transacción***/







/***Funciones definidas por el usuario*****/
If exists(Select * from sys.objects where type_desc like '%Function%' and 
			name='fnCantidadPedidosxVendedor')
	Drop Function dbo.fnCantidadPedidosxVendedor
go

If exists(Select * from sys.objects where type_desc like '%Function%' and 
			name='fntProductosXCategoria')
	Drop Function dbo.fntProductosXCategoria
go

/**Funciones Escalares----Devuelve solo un valor**/

Create Or Alter Function fnCantidadPedidosxVendedor(@p_idVendedor int)
Returns int
As
Begin
	Declare @v_cantidad int
	Set @v_cantidad=(Select count(*) from Pedido where idVendedor=@p_idVendedor)
	Return @v_cantidad
End
go

--Uso de la función
--En un Bloque
Begin
	Declare @v_idVendedor int=2
	Print 'La cantidad de pedidos de dicho vendedor es '+str(dbo.fnCantidadPedidosxVendedor(@v_idVendedor))
End
go

--En una consulta
Select	nomVendedor,
		dbo.fnCantidadPedidosxVendedor(IdVendedor) [Cantidad de Pedidos]
from Vendedor
go

/**Crear una función escalar para determinar la cantidad de Pedidos de un Cliente**/




/*******************************************************************************/

/***Función de Tabla en Linea***/
Create Or Alter Function dbo.fntProductosXCategoria (@p_idcategoria int)
Returns Table
As
	Return(Select C.nomCategoria, P.NomProducto, P.stockProducto, P.precioProducto
			from Producto P Join Categoria C on P.idCategoria=C.IdCategoria
			where P.idCategoria=@p_idcategoria)
go

--Ver el uso de la función
Select * from dbo.fntProductosXCategoria(1)
go

Select * from dbo.fntProductosXCategoria (2)
go

Select * from dbo.fntProductosXCategoria (3)
go

Select * from dbo.fntProductosXCategoria (4)
go

/*Crear una función de tabla en linea que permita mostrar el detalle 
(Id Producto, NomProducto, Categoria, cantidad pedida, precio vta y
total ) de un determinado Pedido*/
