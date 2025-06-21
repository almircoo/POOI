--CreaciÛn de Base de Datos
use master
go

Create Database Lesson1
go

--Ver estructura
sp_helpdb Lesson1
go

--Modificar el archivo de base de datos
Alter Database Lesson1
Modify file
(name=Lesson1, size=20MB, maxsize=250MB, filegrowth=10MB)
go

---
Alter Database Lesson1
Modify file
(name=Lesson1_log, maxsize=500MB)
go

--Alterar la base de datos para adicionar nuevos datafiles
Alter Database Lesson1
Add file
(name=NewData1, filename='D:\FilesDB\srvRio\NewData1.NDF', maxsize=400MB)
go

Alter Database Lesson1
Add file
(name=NewData2, filename='D:\FilesDB\srvMiami\NewData2.NDF', maxsize=500MB)
go

--Alterar la base de datos para adicionar nuevos logfiles en el srvLima
Alter Database Lesson1
Add Log File
(name=Log2, filename='D:\FilesDB\srvLima\Log2.LDF', maxsize=600MB)
go

--Ver estructura
sp_helpdb Lesson1
go

--Version de SQL Server
print @@version
go

--Borrar archivo de base de datos
alter database Lesson1
remove file NewData2
go