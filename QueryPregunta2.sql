
USE MASTER
GO

-- crear base datos
CREATE DATABASE NEGOCIOS;
GO

-- UsAR basedatos
USE NEGOCIOS
GO

-- Tablas cargos
CREATE TABLE Cargos (
    idcargo INT PRIMARY KEY IDENTITY(100,1),
    desCargo VARCHAR(100) NOT NULL
);
GO

-- Tabla Empleados
CREATE TABLE Empleados (
    IdEmpleado INT PRIMARY KEY IDENTITY(1000,1),
    ApeEmpleado VARCHAR(100) NOT NULL,
    NomEmpleado VARCHAR(100) NOT NULL,
    DirEmpleado VARCHAR(200),
    idCargo INT NOT NULL
);
GO

-- inserta datos a Cargos
INSERT INTO Cargos (desCargo) VALUES
('Representante de Ventas'),
('Ejecutivo de Ventas'),
('Supervisor de Ventas'),
('Auxiliar de Ventas');
GO

-- Inserta datos a  Empleados
INSERT INTO Empleados (ApeEmpleado, NomEmpleado, DirEmpleado, idCargo) VALUES
('García', 'Juan', 'Av. Siempre Viva 123', 100),
('Pérez', 'María', 'Calle Falsa 456', 101), 
('Rodríguez', 'Luis', 'Jr. Miraflores 789', 102),
('González', 'Ana', 'Av. El Sol 101', 103), 
('Martínez', 'Pedro', 'Calle Luna 202', 100),
('Sánchez', 'Laura', 'Jr. Estrella 303', 101),
('Ramírez', 'Carlos', 'Av. Palmeras 404', 102),
('Torres', 'Sofía', 'Calle Del Mar 505', 103), 
('Díaz', 'Andrés', 'Jr. Río 606', 100),
('Vargas', 'Carolina', 'Av. Montaña 707', 101);


-- Procedure Empleados con Cargos
-- Procedure Empleados con Cargos
CREATE PROCEDURE sp_ListarEmpleadosConCargo
AS
    SELECT
        e.IdEmpleado,
        e.ApeEmpleado,
        e.NomEmpleado,
        e.DirEmpleado,
        c.desCargo AS Cargo
    FROM
        Empleados e INNER JOIN Cargos c ON e.idCargo = c.idcargo;
GO 

select * from Cargos
select * from Empleados

EXECUTE sp_ListarEmpleadosConCargo;
GO 

-- elimar el procedure
DROP PROCEDURE sp_ListarEmpleadosConCargo;
GO
