/** Cursores **/
use Lesson09
go

/**Recorrido de la tabla vendedor**/
Begin
	--Declarar cursor
	Declare curDemo Cursor For Select * from Vendedor
	--Abrir cursor
	Open curDemo
	--Leer cursor
	Fetch CurDemo
	--Cerrar cursor
	Close curDemo
	--Liberar el cursor de memoria
	Deallocate curDemo
End
go

/**Recorrido de la tabla Categoria**/
Begin
	Declare curDemoCat Cursor For Select * from Categoria
	Open curDemoCat
	Fetch curDemoCat
	While @@fetch_status = 0
	Begin
		Fetch curDemoCat
	End
	Close curDemoCat
	Deallocate curDemoCat
End
go

/*Cursor que muestre nombre Producto, nombre categoria, stock y precio*/
Begin
	Declare curPro cursor for Select p.NomProducto, c.nomCategoria,
									p.stockProducto, p.precioProducto	
							from Producto p Join Categoria C
							on p.idCategoria=c.IdCategoria
	Open curPro
	Fetch curPro
	While @@fetch_status=0
	Begin
		Fetch curPro
	End
	Close curPro
	Deallocate curPro
End
go

/*Cursor que muestre nombre Producto, nombre categoria, stock y precio*/
--Usando variables de cursor e imprimiendo
Begin
	Declare curPro cursor for Select p.NomProducto, c.nomCategoria,
									p.stockProducto, p.precioProducto	
							from Producto p Join Categoria C
							on p.idCategoria=c.IdCategoria
	-----------------------------------------------------
	Declare @v_nomPro varchar(max), @v_nomcat varchar(max)
	Declare @v_stock smallint, @v_precio smallmoney
	-----------------------------------------------------
	Open curPro
	Fetch curPro into @v_nomPro, @v_nomcat, @v_stock, @v_precio
	While @@fetch_status=0
	Begin
		Print 'Producto:'+@v_nomPro
		Print 'Categoria:'+@v_nomcat
		Print 'Stock:'+cast(@v_stock as varchar(10))
		Print 'Precio:'+format(@v_precio,'C','es-pe')
		Print replicate('=',60)
		Fetch curPro into @v_nomPro, @v_nomcat, @v_stock, @v_precio
	End
	Close curPro
	Deallocate curPro
End
go

/**Modificar el cursor anterior para determinar el nivel de stock del producto 
De la siguiente manera:
Si stock es mayor a 100 => SobreStockeado
Si stock es mayor o igual a 50 => Stock Normal
Si stock es menor a 50 => Urgente ReposiciÛn
**/
Begin
	Declare curPro cursor for Select p.NomProducto, c.nomCategoria,
									p.stockProducto, p.precioProducto	
							from Producto p Join Categoria C
							on p.idCategoria=c.IdCategoria
	-----------------------------------------------------
	Declare @v_nomPro varchar(max), @v_nomcat varchar(max)
	Declare @v_stock smallint, @v_precio smallmoney
	-----------------------------------------------------
	Open curPro
	Fetch curPro into @v_nomPro, @v_nomcat, @v_stock, @v_precio
	While @@fetch_status=0
	Begin	
		Declare @v_nivel varchar(max)
		If @v_stock>100
			Set @v_nivel='SobreStockeado'
		else If @v_stock>=50
			Set @v_nivel='Stock Normal'
		else
			Set @v_nivel='Urgente ResposiciÛn'
		Print 'Producto: '+@v_nomPro
		Print 'Categoria: '+@v_nomcat
		Print 'Stock: '+cast(@v_stock as varchar(10))
		Print 'Precio: '+format(@v_precio,'C','es-pe')
		Print 'Nivel Stock: ' + @v_nivel
		Print replicate('=',60)
		Fetch curPro into @v_nomPro, @v_nomcat, @v_stock, @v_precio
	End
	Close curPro
	Deallocate curPro
End
go

---Usando cursores Anidados muestre los datos del vendedor, por cada uno, sus pedidos hechos, 
---mostrando al final el total facturado de cada uno
Begin
	Declare cursorVendedor cursor for Select IdVendedor, nomVendedor from Vendedor
	Declare @v_idVend int, @v_nomVend varchar(max)
	Open cursorVendedor
	Fetch cursorVendedor into @v_idVend, @v_nomVend
	While @@FETCH_STATUS = 0
	Begin
		Print 'Id Vendedor: '+cast(@v_idVend as varchar(5))
		Print 'Vendedor: '+@v_nomVend
		Print Replicate ('-',70)
		---------------------------------------------------------------------------
		Declare curPedido Cursor for Select P.idPedido, P.fecPedido, C.nomCliente from Pedido P join Cliente C
								On P.idCliente=C.idCliente Where P.idVendedor=@v_idVend
		Declare @v_idPedido int, @v_fecPedido date, @v_cliente varchar(max)
		Open curPedido
		Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
		While @@fetch_status = 0
		Begin
			Print space(20)+'Id Pedido: '+cast(@v_idPedido as varchar(10))
			Print space(20)+'Fecha Pedio: '+format(@v_fecPedido,'D','es-pe')
			Print space(20)+'Cliente: '+@v_cliente
			Print space(60)
			Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
		End
		Close curPedido
		Deallocate curPedido
		---------------------------------------------------------------------------
		Print replicate ('*',70)
		Fetch cursorVendedor into @v_idVend, @v_nomVend
	End
	Close cursorVendedor
	Deallocate cursorVendedor
End
go

/**Usando Procedimiento Almacenado, optimice el cursor anterior para que solo muestre los pedidos de 
un detrminado vendedor en un dterminado aÒo**/
Create or Alter Procedure uspOptimusCur
@p_idVen int,
@p_aÒo int
As
Begin
	Declare cursorVendedor cursor for Select IdVendedor, nomVendedor from Vendedor
							Where IdVendedor=@p_idVen
	Declare @v_idVend int, @v_nomVend varchar(max)
	Open cursorVendedor
	Fetch cursorVendedor into @v_idVend, @v_nomVend
	While @@FETCH_STATUS = 0
	Begin
		Print 'Id Vendedor: '+cast(@v_idVend as varchar(5))
		Print 'Vendedor: '+@v_nomVend
		Print Replicate ('-',70)
		---------------------------------------------------------------------------
		Declare curPedido Cursor for Select P.idPedido, P.fecPedido, C.nomCliente from Pedido P join Cliente C
								On P.idCliente=C.idCliente Where P.idVendedor=@v_idVend and year(P.fecPedido)=@p_aÒo
		Declare @v_idPedido int, @v_fecPedido date, @v_cliente varchar(max)
		Open curPedido
		Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
		While @@fetch_status = 0
		Begin
			Print space(20)+'Id Pedido: '+cast(@v_idPedido as varchar(10))
			Print space(20)+'Fecha Pedio: '+format(@v_fecPedido,'D','es-pe')
			Print space(20)+'Cliente: '+@v_cliente
			Print space(60)
			Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
		End
		Close curPedido
		Deallocate curPedido
		---------------------------------------------------------------------------
		Print replicate ('*',70)
		Fetch cursorVendedor into @v_idVend, @v_nomVend
	End
	Close cursorVendedor
	Deallocate cursorVendedor
End
go

---Ejecutar
Execute uspOptimusCur '1','1996'
go

---Ejecutar
Execute uspOptimusCur '10','2025'
go

------------------------------------------------------------------------------------
--Modificar el Procedimiento anterior para validar la existencia del vendedor, de no 
--ser asÌ, genere un error
-------------------------------------------------------------------------------------
Create or Alter Procedure uspOptimusCur
@p_idVen int,
@p_aÒo int
As
Begin
If exists (Select * from vendedor where IdVendedor=@p_idVen)
	Begin
		Declare cursorVendedor cursor for Select IdVendedor, nomVendedor from Vendedor
								Where IdVendedor=@p_idVen
		Declare @v_idVend int, @v_nomVend varchar(max)
		Open cursorVendedor
		Fetch cursorVendedor into @v_idVend, @v_nomVend
		While @@FETCH_STATUS = 0
		Begin
			Print 'Id Vendedor: '+cast(@v_idVend as varchar(5))
			Print 'Vendedor: '+@v_nomVend
			Print Replicate ('-',70)
			---------------------------------------------------------------------------
			Declare curPedido Cursor for Select P.idPedido, P.fecPedido, C.nomCliente from Pedido P join Cliente C
									On P.idCliente=C.idCliente Where P.idVendedor=@v_idVend and year(P.fecPedido)=@p_aÒo
			Declare @v_idPedido int, @v_fecPedido date, @v_cliente varchar(max)
			Open curPedido
			Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
			While @@fetch_status = 0
			Begin
				Print space(20)+'Id Pedido: '+cast(@v_idPedido as varchar(10))
				Print space(20)+'Fecha Pedio: '+format(@v_fecPedido,'D','es-pe')
				Print space(20)+'Cliente: '+@v_cliente
				Print space(60)
				Fetch curPedido into @v_idPedido, @v_fecPedido, @v_cliente
			End
			Close curPedido
			Deallocate curPedido
			---------------------------------------------------------------------------
			Print replicate ('*',70)
			Fetch cursorVendedor into @v_idVend, @v_nomVend
		End
		Close cursorVendedor
		Deallocate cursorVendedor
	End
else
	RaisError ('Vendedor No Existe.....',10,1)
End
go

---Ejecutar
Execute uspOptimusCur '1','1996'
go

/**Procedimientos Almacenados con Par·metros de Entrada y Salida**/
Create or Alter Procedure uspConsulta
@p_idProducto int,
@p_nombre varchar(50) Output,
@p_precio smallmoney OutPut
As
Begin
	Select @p_nombre=NomProducto, @p_precio=precioProducto
	from Producto where IdProducto=@p_idProducto
End
go

/**Ejecutar**/
Begin
	Declare @v_nombre varchar(max), @v_precio smallmoney
	Execute uspConsulta '2',@v_nombre Output, @v_precio Output
	Print @v_nombre
	Print @v_precio
end
go

Begin
	Declare @v_nombre varchar(max), @v_precio smallmoney
	Execute uspConsulta '99',@v_nombre Output, @v_precio Output
	Print @v_nombre
	Print @v_precio
end
go
