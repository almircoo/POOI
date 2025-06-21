use master
go

/**Crear la base de datos BDNabisco con 03 Datafiles ubicados en el srvLima, 
en los filegroups Primary, FGLogistic, FGFinance. Tambien debe tener 02 
LogFiles ubicados en el srvSantiago**/
Create Database BDNabisco
On Primary
	(name=NabiscoDataPrin, filename='D:\filesBD\srvLima\NabiscoDataPri.MDF',maxsize=100MB),
Filegroup FGLogistic
	(name=NabiscoDataLgs1,filename='D:\filesBD\srvLima\NabiscoDataLgs1.NDF',maxsize=100MB),
Filegroup FGFinance
	(name=NabiscoDataFnc1,filename='D:\filesBD\srvLima\NabiscoDataFnc1.NDF',maxsize=100MB)
Log On
	(name=NabiscoLog1, filename='D:\filesBD\srvSantiago\NabiscoLog1.LDF',maxsize=200MB),
	(name=NabiscoLog2, filename='D:\filesBD\srvSantiago\NabiscoLog2.LDF',maxsize=200MB)
go

-----
sp_helpdb BDNabisco
go

Create Database Lesson2
go

sp_helpdb Lesson2
go

Alter Database Lesson2
Add File
(name=DataNew1, filename='D:\FilesBD\srvLima\DataNew1.NDF')
go

-----------------------------------------
Use Lesson2
go

Create Table Planilla
(
id int,
nom varchar(50)
)
go

Create Table Ventas
(
id int,
nom varchar(50)
)
go

----------------------------
Drop Table Planilla
go

Drop Table Ventas
go
---------------------------

--Adicionar a la base de datos nuevos Filegroups
Alter Database Lesson2
Add Filegroup FGRRHH
go

Alter Database Lesson2
Add Filegroup FGSales
go

--Adicionar a la base de datos nuevos datafile en sus respectivos Filegroups
Alter Database Lesson2
Add File
(name=DataRRHH1, filename='D:\FilesBD\srvSantiago\DataRRHH1.NDF')
to filegroup FGRRHH
go

Alter Database Lesson2
Add File
(name=DataSales1, filename='D:\FilesBD\srvMadrid\DataSales1.NDF')
to filegroup FGSales
go

---Demo----
sp_helpdb Lesson2
go

use Lesson2
go

---
Create Table Planilla
(
id int,
nom varchar(50)
) on FGRRHH
go

Create Table Ventas
(
id int,
nom varchar(50)
) on FGSales
go

/** CreaciÛn de Schemas**/
use BDNabisco
go

Create Schema schFinance
go

Create Schema schLogistic
go

Create Schema schSales
go

--Ver los schemas creados
Select * from sys.schemas
go

---Demo (Mala Pr·ctica)
Create Table OperadorLog
(
id int,
nom varchar(50)
) on FGLogistic
go

--Demo (Buena Pr·ctica)
Create Table schFinance.EEFF
(
id int,
nom varchar(50)
) on FGFinance
go

Create Table schFinance.Cuentas
(
id int,
nom varchar(50)
) on FGFinance
go

Create Table schFinance.Inversiones
(
id int,
nom varchar(50)
) on FGFinance
go

-------------
Create Table schLogistic.Transporte
(
id int,
nom varchar(50)
) on FGLogistic
go

------------
Create Table schLogistic.Guia
(
id int,
nom varchar(50)
) on FGLogistic
go

-------------------------
--Alterar el schema para transferir un objeto tabla desde otro schema
Alter Schema schLogistic
transfer dbo.OperadorLog
go