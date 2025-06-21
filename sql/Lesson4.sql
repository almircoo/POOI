Create Database Ransa
go

--Paso 01
Alter Database Ransa
Add filegroup FGSales01
go

Alter Database Ransa
Add filegroup FGSales02
go

Alter Database Ransa
Add filegroup FGSales03
go

--Paso 02 (en el srvLima)
Alter Database Ransa
Add File
(name=NDFRansaSales01, filename='D:\filesBD\srvLima\NDFRansaSales01.NDF')
to filegroup FGSales01
go

Alter Database Ransa
Add File
(name=NDFRansaSales02, filename='D:\filesBD\srvLima\NDFRansaSales02.NDF')
to filegroup FGSales02
go

Alter Database Ransa
Add File
(name=NDFRansaSales03, filename='D:\filesBD\srvLima\NDFRansaSales03.NDF')
to filegroup FGSales03
go

--Paso 03
use Ransa
go

--Paso 04
Create Partition Function fnpVentas (int)
As Range Left for Values (3000,6000)
go

--Paso 05
Create Partition scheme scpVentas
As Partition fnpVentas to (FGSales01, FGSales02, FGSales03) 
go

--Paso 06
Create schema schSales
go

----------
Create Table schSales.Ventas
(
nroVta int,
fecVta date,
valVta smallmoney
) on scpVentas(nroVta)
go

---Demo
Insert schSales.Ventas
Values
('7001','10/10/99','2300'),		--3
('4500','1/1/98','4500'),			--2
('1500','3/3/99','5000'),			--1
('2000','12/12/99','6500'),		--1
('3002','11/11/98','3400'),		--2
('6700','12/12/99','7800'),		--3
('5300','10/01/98','6500')		--2
go

--Consultar
Select * from schSales.Ventas
go

--Consultar indicando el # de particiÛn 
Select * , $partition.fnpVentas(nroVta) [N∞ de ParticiÛn]
from schSales.Ventas
go	

---Crear 04 Filegroups para posteriores 04 particiones.
---La tabla Cliente tendr· los siguientes campos:
---codCli, nomCli, fecNac.
---Los rangos de particionamiento ser·n de la siguiente manera:
---* Rango 1 los nacidos antes del aÒo 1975 (< 01/01/1975)
---* Rango 2 los nacidos antes del aÒo 1985
---* Rango 3 los nacidos antes del aÒo 1995
---* Rango 4 Resto