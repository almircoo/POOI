Create Database Haydok
go

Alter Database Haydok
add filegroup FG001
go

Alter Database Haydok
Add file
(name=NewData1, filename='D:\Files\srvLima\NewData1.NDF', maxsize=250MB)
to filegroup FG001
go

--Data Types--
--SDT (System Data Type)
--UDT (User Define Type)

--Ver idioma del servidor
select @@language
go

--Abrir la base de Datos
use Haydok
go

/* Crear UDT */
--Modo 1
Create Type udtCadena from varchar(50) not null
go

--Modo 2
sp_addtype udtFono,'Char(9)','not null'
go

--------------------------------
--Crear tabla
Create Table dbo.usuario
(
nomUsuario	udtCadena,
telUsuario	udtFono
)
go

-------------------------------
--Borrar tabla
drop table dbo.usuario
go

--Borrar los udt
Drop Type udtCadena
go

Drop Type udtFono
go

-------------------------------
/**Create Tipos de Datos en el schema schSistema**/
Create schema schSistema
go

/**UDT:  **/
-- udtIden		==>	char(5)
Create Type schSistema.udtIden from char(5) not null
go

-- udtNume		==> smallInt
Create Type schSistema.udtInt from smallInt
go

-- udtNumInt	==> int
Create Type schSistema.udtNumInt from int
go

-- udtCoin		==> smallMoney
Create Type schSistema.udtCoin from smallmoney
go

-- udtTiempo	==> dateTime
Create Type schSistema.udtTiempo from datetime
go

-- udtFecha		==> date
Create Type schSistema.udtFecha from date
go

-- udtCadena	==> varchar(50)
Create Type schSistema.udtCadena from varchar(50)
go

--Para visualizar los tipos creados por el usuario
Select * from sys.types
go

--Crear objeto tabla en el schema schSistema usando los udt.
Create Table schSistema.Usuarios
(
codUsua	schSistema.udtIden,
nomUsua schSistema.udtCadena,
fnaUsua schSistema.udtFecha,
freUsua schSistema.udtTiempo,
sueUsua	schSistema.udtCoin
)
go

/*----------------------------------*/
/**** CreaciÛn de Tablas ****/
Create schema schAcademico
go

Create Table schAcademico.Notas
(
codAlum		schSistema.udtIden,
nomAlum		schSistema.udtCadena,
nota1		schSistema.udtInt,
nota2		schSistema.udtInt,
nota3		schSistema.udtInt,
prome		as (nota1 + nota2 + nota3)/3	--solo lectura
) 
go

---Consultar
Select * from schAcademico.Notas
go

--Ingresar
Insert schAcademico.Notas
values
('A001','Coco PeÒa','15','14','13')
go