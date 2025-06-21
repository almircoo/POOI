/*Consultas Agrupadas*/
use Lesson8
go

Select * 
from Pedido
go

------------------------------------------
Select fecPedido 
from Pedido
go

------------------------------------------
Select year(fecPedido) [AÒo de Pedido]
from Pedido
go

---------------Agrupar por aÒo---------------------------
Select year(fecPedido) [AÒo de Pedido]
from Pedido
group by year(fecPedido)
go

---------------------
Select datename(yy,fecPedido) [AÒo de Pedido]
from Pedido
group by datename(yy,fecPedido)
go

---------------Agrupar por idTransporte---------------------------

select idTransporte [idTransporte]
from Pedido
group by idTransporte 

---opt
select  t.nomTransporte  [Nombre empresa de transporte]
from pedido p join Transporte t on p.idTransporte = t.idTransporte
group by  t.nomTransporte
go

---------------Agrupar por idVendedor opt---------------------------
Select v.nomVendedor [Nombre de vendedor]
from Pedido p join Vendedor v on p.idVendedor = v.IdVendedor
group by v.nomVendedor
go

/****** Aplicar una funciÛn de aggregado por grupo ****/
/**Count() , Sum(), Avg(), Max(), Min() **/
---------------------
Select datename(yy,fecPedido) [AÒo de Pedido],
			count(*) [Cantidad de Pedidos]
from Pedido
group by datename(yy,fecPedido)
go

--Aplicar sum() a consulta 
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			sum(D.cantidadPedida*D.precioVenta) [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido
group by datename(yy,P.fecPedido)
go


--Aplicar formato a Total Facturado 
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			format(sum(D.cantidadPedida*D.precioVenta),'C','en-us') [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido
group by datename(yy,P.fecPedido)
go

---
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			format(sum(D.cantidadPedida*D.precioVenta),'C','es-pe') [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido
group by datename(yy,P.fecPedido)
go

---------------Agrupar pedido por Transporte y aplicar conteo---------------------------

---opt
select t.nomTransporte [Nombre Transporte],
			count(*) [Conteo]
from pedido p
join Transporte t on p.idTransporte = t.idTransporte
group by nomTransporte
go

---------------Agrupar pedido por Transporte y hallar total facturado------------------------
select t.nomTransporte [Nombre Transporte],
			Sum(d.cantidadPedida*d.precioVenta) [Total Facturado]
from pedido p join Transporte t on p.idTransporte = t.idTransporte
join DetallePedido d on p.idPedido=d.idPedido
group by nomTransporte
go

/**Agrupar por aÒo y nomtransporte, hallando el total facturado **/
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			T.nomTransporte	[Transporte]  ,
			sum(D.cantidadPedida*D.precioVenta) [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido join Transporte T
on P.idTransporte=T.idTransporte
group by datename(yy,P.fecPedido), T.nomTransporte
go

/**Agrupar por aÒo, vendedor y nomtransporte, hallando el total facturado **/
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			V.nomVendedor [Vendedor],
			T.nomTransporte	[Transporte]  ,
			sum(D.cantidadPedida*D.precioVenta) [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido join Transporte T
on P.idTransporte=T.idTransporte Join Vendedor V
on P.idVendedor=V.IdVendedor
group by datename(yy,P.fecPedido),V.nomVendedor,T.nomTransporte
go

--
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			V.nomVendedor [Vendedor],
			T.nomTransporte	[Transporte]  ,
			format(sum(D.cantidadPedida*D.precioVenta),'C','es-pe') [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido join Transporte T
on P.idTransporte=T.idTransporte Join Vendedor V
on P.idVendedor=V.IdVendedor
group by datename(yy,P.fecPedido),V.nomVendedor,T.nomTransporte
go

--Aplicar Subtotales
--Modo 1 (Rollup)
Select	datename(yy,P.fecPedido) [AÒo de Pedido],
			isnull(V.nomVendedor,' ') [Vendedor],
			isnull(T.nomTransporte,' ')	[Transporte]  ,
			format(sum(D.cantidadPedida*D.precioVenta),'C','es-pe') [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido join Transporte T
on P.idTransporte=T.idTransporte Join Vendedor V
on P.idVendedor=V.IdVendedor
group by datename(yy,P.fecPedido),V.nomVendedor,T.nomTransporte with Rollup
go

--Modo 2 (Cube)
Select	isnull(datename(yy,P.fecPedido),' ') [AÒo de Pedido],
			isnull(V.nomVendedor,' ') [Vendedor],
			isnull(T.nomTransporte, ' ')	[Transporte]  ,
			format(sum(D.cantidadPedida*D.precioVenta),'C','es-pe') [Total Facturado]
from Pedido P join DetallePedido D
on P.idPedido=D.idPedido join Transporte T
on P.idTransporte=T.idTransporte Join Vendedor V
on P.idVendedor=V.IdVendedor
group by datename(yy,P.fecPedido),V.nomVendedor,T.nomTransporte with Cube
go