
create database Copier
go

-- Tabla de Clientes
CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    DNI VARCHAR(8),
	Apellido VARCHAR(50),
    Dirección VARCHAR(255),
    Teléfono VARCHAR(20),
    Email VARCHAR(70),
    FecRegistro DATE
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    EmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Cargo VARCHAR(50),
    Teléfono VARCHAR(20),
    Email VARCHAR(70)
);

-- Tabla de Productos
CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NomProd VARCHAR(100),
    Descripción TEXT,
    Precio DECIMAL(10, 2),
    TipoProd VARCHAR(50)
);

-- Tabla de Servicios
CREATE TABLE Servicios (
    ServicioID INT IDENTITY(1,1) PRIMARY KEY,
    NomServ VARCHAR(100),
    Descripción TEXT,
    Precio DECIMAL(10, 2),
    TipoServ VARCHAR(50)
);

-- Tabla de Ventas
CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    FecVenta DATE,
	FecEntrega DATE,
    MontoTotal DECIMAL(10, 2),
    ClienteID INT,
    EmpleadoID INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

-- Tabla de Detalles de Producto en Venta
CREATE TABLE DetalleProductoVenta (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT,
    ProductoID INT,
    Cantidad INT,
    PrecioUnit DECIMAL(10, 2),
    Descuento DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);


-- Tabla de Detalles de Servicio en Venta
CREATE TABLE DetalleServicioVenta (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT,
    ServicioID INT,
    Cantidad INT,
    PrecioUnit DECIMAL(10, 2),
    Descuento DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ServicioID) REFERENCES Servicios(ServicioID)
);

ALTER TABLE Ventas
ADD Estado VARCHAR(20) DEFAULT 'En proceso'; 

ALTER TABLE Productos
ADD Stock int DEFAULT 150;


select * from Productos

--Constraints

--Asegurar el uso de un único email 
ALTER TABLE Clientes
ADD CONSTRAINT UQ_Email UNIQUE (Email);

ALTER TABLE Empleados
ADD CONSTRAINT UQ_Email_Empleado UNIQUE (Email);

-- Asegurar que las fechas sean validas (no anterior a la actual)
ALTER TABLE Clientes
ADD CONSTRAINT chk_FecRegistro_Valid CHECK (FecRegistro <= GETDATE());

ALTER TABLE Ventas
ADD CONSTRAINT chk_FecVenta_Valid CHECK (FecVenta <= GETDATE());

-- Precios no sean negativos
ALTER TABLE Productos
ADD CONSTRAINT chk_Precio_Producto CHECK (Precio >= 0);

ALTER TABLE Servicios
ADD CONSTRAINT chk_Precio_Servicio CHECK (Precio >= 0);

-- Cantidad sea positiva
ALTER TABLE DetalleProductoVenta
ADD CONSTRAINT chk_Cantidad_ProductoVenta CHECK (Cantidad > 0);

ALTER TABLE DetalleServicioVenta
ADD CONSTRAINT chk_Cantidad_ServicioVenta CHECK (Cantidad > 0);

-- Asegurar que el descuento sea razonable (no exceda el precio del articulo)
ALTER TABLE DetalleProductoVenta
ADD CONSTRAINT chk_Descuento_ProductoVenta CHECK (Descuento BETWEEN 0 AND 100);

ALTER TABLE DetalleServicioVenta
ADD CONSTRAINT chk_Descuento_ServicioVenta CHECK (Descuento BETWEEN 0 AND 100);

-- Asegurar de que no tengan el mismo nombre
ALTER TABLE Productos
ADD CONSTRAINT UQ_NomProd UNIQUE (NomProd);

ALTER TABLE Servicios
ADD CONSTRAINT UQ_NomServ UNIQUE (NomServ);

-- Que FecEntrega no sea antes de la FecVenta
ALTER TABLE Ventas
ADD CONSTRAINT chk_FecEntrega_Valid CHECK (FecEntrega >= FecVenta);

select * from Clientes

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, DNI, Apellido, Dirección, Teléfono, Email, FecRegistro) VALUES
('Juan', '12345678', 'Pérez', 'Av. Larco 123', '955512345', 'juan.perez@gmail.com', '2023-01-01'),
('María', '87654321', 'López', 'Calle Alcanfores 742', '955556789', 'maria.lopez@gmail.com', '2023-02-01'),
('Carlos', '11223344', 'García', 'Jr. de la Unión 456', '955598765', 'carlos.garcia@gmail.com', '2023-03-01'),
('Ana', '44332211', 'Martínez', 'Av. Pardo 789', '955543219', 'ana.martinez@gmail.com', '2023-04-01'),
('Luis', '55667788', 'Hernández', 'Av. Brasil 555', '955567891', 'luis.hernandez@gmail.com', '2023-05-01'),
('Elena', '66778899', 'Fernández', 'Calle Schell 222', '955523456', 'elena.fernandez@gmail.com', '2023-06-01'),
('Roberto', '99887766', 'Ramírez', 'Av. Arequipa 321', '955534567', 'roberto.ramirez@gmail.com', '2023-07-01'),
('Lucía', '22334455', 'Sánchez', 'Av. Salaverry 987', '955545678', 'lucia.sanchez@gmail.com', '2023-08-01'),
('Fernando', '33445566', 'Gutiérrez', 'Calle San Martín 654', '955556701', 'fernando.gutierrez@gmail.com', '2023-09-01'),
('Clara', '44556677', 'Vargas', 'Av. Angamos 1234', '955567812', 'clara.vargas@gmail.com', '2023-10-01'),
('José', '55667788', 'Torres', 'Av. Benavides 1111', '955578923', 'jose.torres@gmail.com', '2023-11-01'),
('Lia', '66778899', 'Molina', 'Gonzales Prada 102', '955589034', 'lia.molina@gmail.com', '2023-12-01'),
('Miguel', '77889900', 'Morales', 'Av. Javier Prado 555', '955590145', 'miguel.morales@gmail.com', '2023-01-02'),
('Raquel', '88990011', 'Ortiz', 'Calle Berlín 444', '955501256', 'raquel.ortiz@gmail.com', '2023-02-02'),
('Adrián', '99001122', 'Mendoza', 'Av. La Marina 678', '955512367', 'adrian.mendoza@gmail.com', '2023-03-02');

-- Insertar datos en la tabla Empleados
INSERT INTO Empleados (Nombre, Apellido, Cargo, Teléfono, Email) VALUES
('Pedro', 'Gómez', 'Vendedor', '955578901', 'pedro.gomez@gmail.com'),
('Laura', 'Torres', 'Gerente', '955589012', 'laura.torres@gmail.com'),
('Jorge', 'Ruiz', 'Técnico', '955590123', 'jorge.ruiz@gmail.com'),
('Marta', 'Ramírez', 'Asistente', '955501234', 'marta.ramirez@gmail.com'),
('Sofía', 'Morales', 'Recepcionista', '955512345', 'sofia.morales@gmail.com'),
('Ignacio', 'Fernández', 'Supervisor', '955523456', 'ignacio.fernandez@gmail.com'),
('Valeria', 'Suárez', 'Administrativo', '955534567', 'valeria.suarez@gmail.com'),
('Eduardo', 'Martínez', 'Vendedor', '955545678', 'eduardo.martinez@gmail.com'),
('Paula', 'López', 'Gerente', '955556789', 'paula.lopez@gmail.com'),
('Diego', 'Hernández', 'Técnico', '955567890', 'diego.hernandez@gmail.com'),
('Carolina', 'García', 'Asistente', '955578901', 'carolina.garcia@gmail.com'),
('Andrés', 'Pérez', 'Recepcionista', '955589012', 'andres.perez@gmail.com'),
('Camila', 'Rodríguez', 'Supervisor', '955590123', 'camila.rodriguez@gmail.com'),
('Esteban', 'Gómez', 'Administrativo', '955501234', 'esteban.gomez@gmail.com'),
('Gabriela', 'Vargas', 'Vendedor', '955512345', 'gabriela.vargas@gmail.com');

select * from  Ventas

-- Insertar datos en la tabla Productos
INSERT INTO Productos (NomProd, Descripción, Precio, TipoProd) VALUES
('Impresora Láser', 'Impresora láser de alta calidad', 299.99, 'Electrónica'),
('Cartucho de Tinta', 'Cartucho de tinta negra', 19.99, 'Consumibles'),
('Papel Fotográfico', 'Papel fotográfico brillante', 12.99, 'Consumibles'),
('Escáner', 'Escáner de documentos', 149.99, 'Electrónica'),
('Multifuncional', 'Impresora multifuncional', 399.99, 'Electrónica'),
('Toner', 'Toner de alta capacidad', 79.99, 'Consumibles'),
('Impresora de Inyección', 'Impresora de inyección de tinta', 249.99, 'Electrónica'),
('Papel Bond', 'Papel bond tamaño carta', 5.99, 'Consumibles'),
('Cinta Correctora', 'Cinta correctora para impresoras', 9.99, 'Consumibles'),
('Plotter', 'Plotter de gran formato', 599.99, 'Electrónica'),
('Impresora 3D', 'Impresora 3D de escritorio', 799.99, 'Electrónica'),
('Kit de Mantenimiento', 'Kit de mantenimiento para impresoras', 49.99, 'Consumibles'),
('Impresora Térmica', 'Impresora térmica de recibos', 89.99, 'Electrónica'),
('Papel Reciclado', 'Papel reciclado tamaño carta', 7.99, 'Consumibles'),
('Cartucho de Color', 'Cartucho de tinta color', 29.99, 'Consumibles');

-- Insertar datos en la tabla Servicios
INSERT INTO Servicios (NomServ, Descripción, Precio, TipoServ) VALUES
('Mantenimiento de Impresoras', 'Servicio de mantenimiento para impresoras', 50.00, 'Mantenimiento'),
('Reparación de Impresoras', 'Reparación de impresoras averiadas', 75.00, 'Reparación'),
('Instalación de Software', 'Instalación de software de impresión', 30.00, 'Instalación'),
('Digitalización de Documentos', 'Servicio de digitalización de documentos', 40.00, 'Digitalización'),
('Capacitación de Uso', 'Capacitación para el uso de equipos', 100.00, 'Capacitación'),
('Consultoría Técnica', 'Consultoría técnica en impresión', 150.00, 'Consultoría'),
('Alquiler de Equipos', 'Alquiler de impresoras y escáneres', 200.00, 'Alquiler'),
('Actualización de Software', 'Actualización de software de impresión', 60.00, 'Actualización'),
('Diagnóstico de Fallas', 'Diagnóstico de fallas en impresoras', 35.00, 'Diagnóstico'),
('Optimización de Rendimiento', 'Optimización de rendimiento de equipos', 120.00, 'Optimización'),
('Soporte Técnico', 'Soporte técnico remoto', 80.00, 'Soporte'),
('Configuración de Red', 'Configuración de impresoras en red', 110.00, 'Configuración'),
('Limpieza de Equipos', 'Limpieza y mantenimiento de equipos', 70.00, 'Limpieza'),
('Reciclaje de Consumibles', 'Reciclaje de cartuchos y toners', 20.00, 'Reciclaje'),
('Venta de Repuestos', 'Venta de repuestos para impresoras', 90.00, 'Venta');

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (FecVenta, FecEntrega, MontoTotal, ClienteID, EmpleadoID) VALUES
('2023-06-01', '2023-06-03', 350.00, 1, 1),
('2023-06-05', '2023-06-07', 450.00, 2, 2),
('2023-06-10', '2023-06-12', 275.00, 3, 3),
('2023-06-15', '2023-06-17', 300.00, 4, 4),
('2023-06-20', '2023-06-22', 550.00, 5, 5),
('2023-06-25', '2023-06-27', 275.00, 6, 6),
('2023-07-01', '2023-07-03', 600.00, 7, 7),
('2023-07-05', '2023-07-07', 200.00, 8, 8),
('2023-07-10', '2023-07-12', 350.00, 9, 9),
('2023-07-15', '2023-07-17', 400.00, 10, 10),
('2023-07-20', '2023-07-22', 150.00, 11, 11),
('2023-07-25', '2023-07-27', 500.00, 12, 12),
('2023-08-01', '2023-08-03', 275.00, 13, 13),
('2023-08-05', '2023-08-07', 600.00, 14, 14),
('2023-08-10', '2023-08-12', 700.00, 15, 15);



-- Insertar datos en la tabla DetalleProductoVenta
INSERT INTO DetalleProductoVenta (VentaID, ProductoID, Cantidad, PrecioUnit, Descuento, Subtotal) VALUES
(1, 1, 1, 299.99, 10.00, 269.99),
(1, 2, 2, 19.99, 0.00, 39.98),
(2, 3, 5, 12.99, 5.00, 59.95),
(2, 4, 1, 149.99, 0.00, 149.99),
(3, 5, 1, 399.99, 50.00, 349.99),
(4, 6, 1, 79.99, 10.00, 71.99),
(5, 7, 2, 249.99, 0.00, 499.98),
(6, 8, 10, 5.99, 1.00, 49.90),
(7, 9, 5, 9.99, 0.00, 49.95),
(8, 10, 1, 599.99, 50.00, 549.99),
(9, 11, 1, 799.99, 100.00, 699.99),
(10, 12, 1, 49.99, 5.00, 44.99),
(11, 13, 2, 89.99, 0.00, 179.98),
(12, 14, 10, 7.99, 2.00, 59.90),
(13, 15, 3, 29.99, 5.00, 84.97);

-- Insertar datos en la tabla DetalleServicioVenta
INSERT INTO DetalleServicioVenta (VentaID, ServicioID, Cantidad, PrecioUnit, Descuento, Subtotal) VALUES
(1, 1, 1, 50.00, 5.00, 45.00),
(2, 2, 1, 75.00, 10.00, 65.00),
(3, 3, 1, 30.00, 0.00, 30.00),
(4, 4, 1, 40.00, 0.00, 40.00),
(5, 5, 1, 100.00, 15.00, 85.00),
(6, 6, 1, 150.00, 20.00, 130.00),
(7, 7, 1, 200.00, 30.00, 170.00),
(8, 8, 1, 60.00, 5.00, 55.00),
(9, 9, 1, 35.00, 0.00, 35.00),
(10, 10, 1, 120.00, 10.00, 110.00),
(11, 11, 1, 80.00, 0.00, 80.00),
(12, 12, 1, 110.00, 5.00, 105.00),
(13, 13, 1, 70.00, 10.00, 60.00),
(14, 14, 1, 20.00, 0.00, 20.00),
(15, 15, 1, 90.00, 15.00, 75.00);

--UPDATES Y DELETES

--CLIENTES:
-- Actualizaciones

UPDATE Clientes
SET DNI = '98765432B'
WHERE ClienteID = 1;

UPDATE Clientes
SET Direccion = 'Dirección nueva 123'
WHERE ClienteID = 2;

UPDATE Clientes
SET Telefono = '+1122334455'
WHERE ClienteID = 3;

UPDATE Clientes
SET Email = 'email2@gmail.com'
WHERE ClienteID = 4;

-- Eliminaciones:
DELETE FROM Clientes
WHERE DNI IS NULL;


DELETE FROM Clientes
WHERE Dirección = '';


DELETE FROM Clientes
WHERE Teléfono IS NULL;


DELETE FROM Clientes
WHERE Email = '';

--EMPLEADOS:
-- UpdateS
UPDATE Empleados
SET Nombre = 'Nuevo Nombre'
WHERE EmpleadoID = 1;

UPDATE Empleados
SET Apellido = 'Nuevo Apellido'
WHERE EmpleadoID = 2;

UPDATE Empleados
SET Cargo = 'Técnico'
WHERE EmpleadoID = 3;

UPDATE Empleados
SET Teléfono = '+1122334466'
WHERE EmpleadoID = 4;

UPDATE Empleados
SET Email = 'emailNuevoEmpleado@gmail.com'
WHERE EmpleadoID = 5;

--Deletes:
DELETE FROM Empleados
WHERE Nombre IS NULL;

DELETE FROM Empleados
WHERE Apellido = '';

DELETE FROM Empleados
WHERE Cargo = '';

DELETE FROM Empleados
WHERE Teléfono IS NULL;

DELETE FROM Empleados
WHERE Email = '';

--PRODUCTOS:
--UPDATES
UPDATE Productos
SET NomProd = 'NombreNuevoProducto'
WHERE ProductoID = 1;

UPDATE Productos
SET Descripción = 'DescripciónNueva'
WHERE ProductoID = 2;

UPDATE Productos
SET Precio = 29.99
WHERE ProductoID = 3;

UPDATE Productos
SET TipoProd = 'TipoNuevoProducto'
WHERE ProductoID = 4;

UPDATE Productos
SET Stock = 0
WHERE ProductoID = 9;

-- Deletes
DELETE FROM Productos
WHERE NomProd IS NULL;

DELETE FROM Productos
WHERE Descripción = '';

DELETE FROM Productos
WHERE Precio IS NULL;

DELETE FROM Productos
WHERE TipoProd = '';

--SERVICIOS:
--Updates
UPDATE Servicios
SET NomServ = 'NombreNuevoServicio'
WHERE ServicioID = 1;

UPDATE Servicios
SET Descripción = 'DescripciónNuevaServicio'
WHERE ServicioID = 2;

UPDATE Servicios
SET Precio = 49.99
WHERE ServicioID = 3;

UPDATE Servicios
SET TipoServ = 'TipoNuevoServicio'
WHERE ServicioID = 4;



--Deletes
DELETE FROM Servicios
WHERE NomServ IS NULL;

DELETE FROM Servicios
WHERE Descripción = '';

DELETE FROM Servicios
WHERE Precio IS NULL;

DELETE FROM Servicios
WHERE TipoServ = '';

--VENTAS:
--Updates
UPDATE Ventas
SET FecVenta = '2024-06-27'
WHERE VentaID = 1;

UPDATE Ventas
SET FecEntrega = '2024-07-05'
WHERE VentaID = 2;

--Deletes
DELETE FROM Ventas
WHERE FecVenta = '2024-06-27';

DELETE FROM Ventas
WHERE FecEntrega = '2024-07-05';

--DetalleProductoVenta
--Updates
UPDATE DetalleProductoVenta
SET Cantidad = 5
WHERE DetalleID = 1;

UPDATE DetalleProductoVenta
SET Descuento = 2.50
WHERE DetalleID = 2;

UPDATE DetalleProductoVenta
SET  PrecioUnit = 15.99
WHERE DetalleID = 1;

UPDATE DetalleProductoVenta
SET  Subtotal = Cantidad * PrecioUnit - Descuento
WHERE DetalleID = 2;

--Deletes
DELETE FROM DetalleProductoVenta
WHERE DetalleID = 3;

DELETE FROM DetalleProductoVenta
WHERE Cantidad <= 0;

DELETE FROM DetalleProductoVenta
WHERE PrecioUnit IS NULL;

--DetalleServicioVenta
--Updates
UPDATE DetalleServicioVenta
SET Cantidad = 3
WHERE DetalleID = 1;

UPDATE DetalleServicioVenta
SET Descuento = 5.00
WHERE DetalleID = 2;

UPDATE DetalleServicioVenta
SET PrecioUnit = 25.50
WHERE DetalleID = 1;

UPDATE DetalleServicioVenta
SET Subtotal = Cantidad * PrecioUnit - Descuento
WHERE DetalleID = 2;

--Deletes
DELETE FROM DetalleServicioVenta
WHERE DetalleID = 3;

DELETE FROM DetalleServicioVenta
WHERE Cantidad <= 0;

DELETE FROM DetalleServicioVenta
WHERE PrecioUnit IS NULL;

--VIEWS

CREATE VIEW VistaVentasClienteEmpleado AS
SELECT V.VentaID, V.FecVenta, V.FecEntrega, V.MontoTotal, C.Nombre AS NombreCliente, E.Nombre AS NombreEmpleado
FROM Ventas V
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
INNER JOIN Empleados E ON V.EmpleadoID = E.EmpleadoID;

select * from VistaVentasClienteEmpleado

CREATE VIEW VistaDetalleProductosVenta AS
SELECT DPV.DetalleID, DPV.VentaID, DPV.ProductoID, P.NomProd, DPV.Cantidad, DPV.PrecioUnit, DPV.Descuento, DPV.Subtotal
FROM DetalleProductoVenta DPV
INNER JOIN Productos P ON DPV.ProductoID = P.ProductoID;

select * from VistaDetalleProductosVenta

CREATE VIEW VistaDetalleServiciosVenta AS
SELECT DSV.DetalleID, DSV.VentaID, DSV.ServicioID, S.NomServ, DSV.Cantidad, DSV.PrecioUnit, DSV.Descuento, DSV.Subtotal
FROM DetalleServicioVenta DSV
INNER JOIN Servicios S ON DSV.ServicioID = S.ServicioID;

select * from VistaDetalleServiciosVenta

CREATE VIEW VistaProductosSinStock AS
SELECT *
FROM Productos
WHERE Stock = 0;

select * from VistaProductosSinStock


CREATE VIEW VistaVentasPorMes AS
SELECT MONTH(FecVenta) AS Mes, YEAR(FecVenta) AS Año, SUM(MontoTotal) AS TotalVentas
FROM Ventas
GROUP BY YEAR(FecVenta), MONTH(FecVenta);

select * from VistaVentasPorMes
ORDER BY Año, Mes;

select * from VistaVentasPorMes


CREATE VIEW ProductosMasVendidos AS
SELECT DPV.ProductoID, P.NomProd AS Producto, SUM(DPV.Cantidad) AS TotalVendido, SUM(DPV.Subtotal) AS MontoTotal
FROM DetalleProductoVenta DPV
INNER JOIN Productos P ON DPV.ProductoID = P.ProductoID
GROUP BY DPV.ProductoID, P.NomProd;

select * from ProductosMasVendidos
ORDER BY TotalVendido desc;

CREATE VIEW ServiciosMasSolicitados AS
SELECT DSV.ServicioID, S.NomServ AS Servicio, SUM(DSV.Cantidad) AS TotalSolicitado, SUM(DSV.Subtotal) AS MontoTotal
FROM DetalleServicioVenta DSV
INNER JOIN Servicios S ON DSV.ServicioID = S.ServicioID
GROUP BY DSV.ServicioID, S.NomServ;

select * from ServiciosMasSolicitados
ORDER BY TotalSolicitado desc;

CREATE VIEW ClientesConMayorGasto AS
SELECT V.ClienteID, C.Nombre AS Cliente, SUM(V.MontoTotal) AS TotalGastado
FROM Ventas V
INNER JOIN Clientes C ON V.ClienteID = C.ClienteID
GROUP BY V.ClienteID, C.Nombre

select * from ClientesConMayorGasto
ORDER BY TotalGastado DESC;

CREATE VIEW VentasPorTipoProducto AS
SELECT P.TipoProd AS TipoProducto, SUM(DPV.Cantidad) AS TotalVendido, SUM(DPV.Subtotal) AS MontoTotal
FROM DetalleProductoVenta DPV
INNER JOIN Productos P ON DPV.ProductoID = P.ProductoID
GROUP BY P.TipoProd;

select * from VentasPorTipoProducto

CREATE VIEW VentasPorTipoServicio AS
SELECT S.TipoServ AS TipoServicio, SUM(DSV.Cantidad) AS TotalSolicitado, SUM(DSV.Subtotal) AS MontoTotal
FROM DetalleServicioVenta DSV
INNER JOIN Servicios S ON DSV.ServicioID = S.ServicioID
GROUP BY S.TipoServ;

select * from VentasPorTipoServicio




-- Procedimiento almacenado para insertar un cliente
CREATE PROCEDURE InsertarCliente
    @Nombre VARCHAR(100),
    @DNI VARCHAR(100),
    @Apellido VARCHAR(100),
    @Direccion VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100),
    @FecRegistro DATE
AS
BEGIN
    INSERT INTO Clientes (Nombre, DNI, Apellido, Dirección, Teléfono, Email, FecRegistro)
    VALUES (@Nombre, @DNI, @Apellido, @Direccion, @Telefono, @Email, @FecRegistro);
END
GO

-- Procedimiento almacenado para actualizar un cliente
CREATE PROCEDURE ActualizarCliente
    @ClienteID INT,
    @Nombre VARCHAR(100),
    @DNI VARCHAR(100),
    @Apellido VARCHAR(100),
    @Direccion VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100),
    @FecRegistro DATE
AS
BEGIN
    UPDATE Clientes
    SET Nombre = @Nombre,
        DNI = @DNI,
        Apellido = @Apellido,
        Dirección = @Direccion,
        Teléfono = @Telefono,
        Email = @Email,
        FecRegistro = @FecRegistro
    WHERE ClienteID = @ClienteID;
END
GO

-- Procedimiento almacenado para eliminar un cliente
CREATE PROCEDURE EliminarCliente
    @ClienteID INT
AS
BEGIN
    DELETE FROM Clientes
    WHERE ClienteID = @ClienteID;
END
GO

-- Procedimiento almacenado para consultar clientes
CREATE PROCEDURE ConsultarClientes
AS
BEGIN
    SELECT * FROM Clientes;
END
GO

-- Procedimiento almacenado para insertar un empleado
CREATE PROCEDURE InsertarEmpleado
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100)
AS
BEGIN
    INSERT INTO Empleados (Nombre, Apellido, Cargo, Teléfono, Email)
    VALUES (@Nombre, @Apellido, @Cargo, @Telefono, @Email);
END
GO

-- Procedimiento almacenado para actualizar un empleado
CREATE PROCEDURE ActualizarEmpleado
    @EmpleadoID INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE Empleados
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Cargo = @Cargo,
        Teléfono = @Telefono,
        Email = @Email
    WHERE EmpleadoID = @EmpleadoID;
END
GO

-- Procedimiento almacenado para eliminar un empleado
CREATE PROCEDURE EliminarEmpleado
    @EmpleadoID INT
AS
BEGIN
    DELETE FROM Empleados
    WHERE EmpleadoID = @EmpleadoID;
END
GO

-- Procedimiento almacenado para consultar empleados
CREATE PROCEDURE ConsultarEmpleados
AS
BEGIN
    SELECT * FROM Empleados;
END
GO

-- Procedimiento almacenado para insertar un producto
CREATE PROCEDURE InsertarProducto
    @NomProd VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoProd VARCHAR(100)
AS
BEGIN
    INSERT INTO Productos (NomProd, Descripción, Precio, TipoProd)
    VALUES (@NomProd, @Descripcion, @Precio, @TipoProd);
END
GO

-- Procedimiento almacenado para actualizar un producto
CREATE PROCEDURE ActualizarProducto
    @ProductoID INT,
    @NomProd VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoProd VARCHAR(100)
AS
BEGIN
    UPDATE Productos
    SET NomProd = @NomProd,
        Descripción = @Descripcion,
        Precio = @Precio,
        TipoProd = @TipoProd
    WHERE ProductoID = @ProductoID;
END
GO

-- Procedimiento almacenado para eliminar un producto
CREATE PROCEDURE EliminarProducto
    @ProductoID INT
AS
BEGIN
    DELETE FROM Productos
    WHERE ProductoID = @ProductoID;
END
GO

-- Procedimiento almacenado para consultar productos
CREATE PROCEDURE ConsultarProductos
AS
BEGIN
    SELECT * FROM Productos;
END
GO

-- Procedimiento almacenado para insertar un servicio
CREATE PROCEDURE InsertarServicio
    @NomServ VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoServ VARCHAR(100)
AS
BEGIN
    INSERT INTO Servicios (NomServ, Descripción, Precio, TipoServ)
    VALUES (@NomServ, @Descripcion, @Precio, @TipoServ);
END
GO

-- Procedimiento almacenado para actualizar un servicio
CREATE PROCEDURE ActualizarServicio
    @ServicioID INT,
    @NomServ VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoServ VARCHAR(100)
AS
BEGIN
    UPDATE Servicios
    SET NomServ = @NomServ,
        Descripción = @Descripcion,
        Precio = @Precio,
        TipoServ = @TipoServ
    WHERE ServicioID = @ServicioID;
END
GO

-- Procedimiento almacenado para eliminar un servicio
CREATE PROCEDURE EliminarServicio
    @ServicioID INT
AS
BEGIN
    DELETE FROM Servicios
    WHERE ServicioID = @ServicioID;
END
GO

-- Procedimiento almacenado para consultar servicios
CREATE PROCEDURE ConsultarServicios
AS
BEGIN
    SELECT * FROM Servicios;
END
GO


-- Procedimiento almacenado para insertar una venta
CREATE PROCEDURE InsertarVenta
    @FecVenta DATE,
    @FecEntrega DATE,
    @MontoTotal DECIMAL(10, 2),
    @ClienteID INT,
    @EmpleadoID INT
AS
BEGIN
    INSERT INTO Ventas (FecVenta, FecEntrega, MontoTotal, ClienteID, EmpleadoID)
    VALUES (@FecVenta, @FecEntrega, @MontoTotal, @ClienteID, @EmpleadoID);
END
GO

-- Procedimiento almacenado para actualizar una venta
CREATE PROCEDURE ActualizarVenta
    @VentaID INT,
    @FecVenta DATE,
    @FecEntrega DATE,
    @MontoTotal DECIMAL(10, 2),
    @ClienteID INT,
    @EmpleadoID INT,
    @Estado VARCHAR(100)
AS
BEGIN
    UPDATE Ventas
    SET FecVenta = @FecVenta,
        FecEntrega = @FecEntrega,
        MontoTotal = @MontoTotal,
        ClienteID = @ClienteID,
        EmpleadoID = @EmpleadoID,
        Estado = @Estado
    WHERE VentaID = @VentaID;
END
GO


-- Procedimiento almacenado para eliminar una venta
CREATE PROCEDURE EliminarVenta
    @VentaID INT
AS
BEGIN
    DELETE FROM Ventas
    WHERE VentaID = @VentaID;
END
GO

-- Procedimiento almacenado para consultar ventas
CREATE PROCEDURE ConsultarVentas
AS
BEGIN
    SELECT * FROM Ventas;
END
GO

-- Procedimiento almacenado para insertar detalle de producto en venta
CREATE PROCEDURE InsertarDetalleProductoVenta
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO DetalleProductoVenta (VentaID, ProductoID, Cantidad, PrecioUnit, Descuento, Subtotal)
    VALUES (@VentaID, @ProductoID, @Cantidad, @PrecioUnit, @Descuento, @Subtotal);
END
GO

-- Procedimiento almacenado para actualizar detalle de producto en venta
CREATE PROCEDURE ActualizarDetalleProductoVenta
    @DetalleID INT,
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
AS
BEGIN
    UPDATE DetalleProductoVenta
    SET VentaID = @VentaID,
        ProductoID = @ProductoID,
        Cantidad = @Cantidad,
        PrecioUnit = @PrecioUnit,
        Descuento = @Descuento,
        Subtotal = @Subtotal
    WHERE DetalleID = @DetalleID;
END
GO

-- Procedimiento almacenado para eliminar detalle de producto en venta
CREATE PROCEDURE EliminarDetalleProductoVenta
    @DetalleID INT
AS
BEGIN
    DELETE FROM DetalleProductoVenta
    WHERE DetalleID = @DetalleID;
END
GO

-- Procedimiento almacenado para consultar detalles de productos en venta
CREATE PROCEDURE ConsultarDetallesProductoVenta
AS
BEGIN
    SELECT * FROM DetalleProductoVenta;
END
GO

-- Procedimiento almacenado para insertar detalle de servicio en venta
CREATE PROCEDURE InsertarDetalleServicioVenta
    @VentaID INT,
    @ServicioID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO DetalleServicioVenta (VentaID, ServicioID, Cantidad, PrecioUnit, Descuento, Subtotal)
    VALUES (@VentaID, @ServicioID, @Cantidad, @PrecioUnit, @Descuento, @Subtotal);
END
GO

--FUNCIONES
-- Función para insertar un cliente
CREATE FUNCTION dbo.fn_InsertarCliente
(
    @Nombre VARCHAR(100),
    @DNI VARCHAR(100),
    @Apellido VARCHAR(100),
    @Direccion VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100),
    @FecRegistro DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarCliente 
        @Nombre, 
        @DNI, 
        @Apellido, 
        @Direccion, 
        @Telefono, 
        @Email, 
        @FecRegistro;
    RETURN @Resultado;
END
GO
EXEC dbo.InsertarCliente 'adley', 72225588, 'munoz', 'calle springfield 123',999222333,'adley.munoz@gmail.com', '2024-06-27'

-- Función para actualizar un cliente
CREATE FUNCTION dbo.fn_ActualizarCliente
(
    @ClienteID INT,
    @Nombre VARCHAR(100),
    @DNI VARCHAR(100),
    @Apellido VARCHAR(100),
    @Direccion VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100),
    @FecRegistro DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarCliente 
        @ClienteID, 
        @Nombre, 
        @DNI, 
        @Apellido, 
        @Direccion, 
        @Telefono, 
        @Email, 
        @FecRegistro;
    RETURN @Resultado;
END
GO


-- Función para eliminar un cliente
CREATE FUNCTION dbo.fn_EliminarCliente
(
    @ClienteID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarCliente @ClienteID;
    RETURN @Resultado;
END
GO

-- Función para consultar clientes
CREATE FUNCTION dbo.fn_ConsultarClientes()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Clientes
);
GO

-- Función para insertar un empleado
CREATE FUNCTION dbo.fn_InsertarEmpleado
(
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarEmpleado 
        @Nombre, 
        @Apellido, 
        @Cargo, 
        @Telefono, 
        @Email;
    RETURN @Resultado;
END
GO

-- Función para actualizar un empleado
CREATE FUNCTION dbo.fn_ActualizarEmpleado
(
    @EmpleadoID INT,
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @Cargo VARCHAR(100),
    @Telefono VARCHAR(100),
    @Email VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarEmpleado 
        @EmpleadoID, 
        @Nombre, 
        @Apellido, 
        @Cargo, 
        @Telefono, 
        @Email;
    RETURN @Resultado;
END
GO

-- Función para eliminar un empleado
CREATE FUNCTION dbo.fn_EliminarEmpleado
(
    @EmpleadoID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarEmpleado @EmpleadoID;
    RETURN @Resultado;
END
GO

-- Función para consultar empleados
CREATE FUNCTION dbo.fn_ConsultarEmpleados()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Empleados
);
GO

-- Función para insertar un producto
CREATE FUNCTION dbo.fn_InsertarProducto
(
    @NomProd VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoProd VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarProducto 
        @NomProd, 
        @Descripcion, 
        @Precio, 
        @TipoProd;
    RETURN @Resultado;
END
GO

-- Función para actualizar un producto
CREATE FUNCTION dbo.fn_ActualizarProducto
(
    @ProductoID INT,
    @NomProd VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoProd VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarProducto 
        @ProductoID, 
        @NomProd, 
        @Descripcion, 
        @Precio, 
        @TipoProd;
    RETURN @Resultado;
END
GO

-- Función para eliminar un producto
CREATE FUNCTION dbo.fn_EliminarProducto
(
    @ProductoID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarProducto @ProductoID;
    RETURN @Resultado;
END
GO

-- Función para consultar productos
CREATE FUNCTION dbo.fn_ConsultarProductos()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Productos
);
GO

-- Función para insertar un servicio
CREATE FUNCTION dbo.fn_InsertarServicio
(
    @NomServ VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoServ VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarServicio 
        @NomServ, 
        @Descripcion, 
        @Precio, 
        @TipoServ;
    RETURN @Resultado;
END
GO

-- Función para actualizar un servicio
CREATE FUNCTION dbo.fn_ActualizarServicio
(
    @ServicioID INT,
    @NomServ VARCHAR(100),
    @Descripcion TEXT,
    @Precio DECIMAL(10, 2),
    @TipoServ VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarServicio 
        @ServicioID, 
        @NomServ, 
        @Descripcion, 
        @Precio, 
        @TipoServ;
    RETURN @Resultado;
END
GO

-- Función para eliminar un servicio
CREATE FUNCTION dbo.fn_EliminarServicio
(
    @ServicioID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarServicio @ServicioID;
    RETURN @Resultado;
END
GO

-- Función para consultar servicios
CREATE FUNCTION dbo.fn_ConsultarServicios()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Servicios
);
GO

-- Función para insertar una venta
CREATE FUNCTION dbo.fn_InsertarVenta
(
    @FecVenta DATE,
    @FecEntrega DATE,
    @MontoTotal DECIMAL(10, 2),
    @ClienteID INT,
    @EmpleadoID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarVenta 
        @FecVenta, 
        @FecEntrega, 
        @MontoTotal, 
        @ClienteID, 
        @EmpleadoID;
    RETURN @Resultado;
END
GO

-- Función para actualizar una venta
CREATE FUNCTION dbo.fn_ActualizarVenta
(
    @VentaID INT,
    @FecVenta DATE,
    @FecEntrega DATE,
    @MontoTotal DECIMAL(10, 2),
    @ClienteID INT,
    @EmpleadoID INT,
    @Estado VARCHAR(100)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarVenta 
        @VentaID, 
        @FecVenta, 
        @FecEntrega, 
        @MontoTotal, 
        @ClienteID, 
        @EmpleadoID, 
        @Estado;
    RETURN @Resultado;
END
GO

-- Función para eliminar una venta
CREATE FUNCTION dbo.fn_EliminarVenta
(
    @VentaID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarVenta @VentaID;
    RETURN @Resultado;
END
GO

-- Función para consultar ventas
CREATE FUNCTION dbo.fn_ConsultarVentas()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Ventas
);
GO

-- Función para insertar detalle de producto en venta
CREATE FUNCTION dbo.fn_InsertarDetalleProductoVenta
(
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarDetalleProductoVenta 
        @VentaID, 
        @ProductoID, 
        @Cantidad, 
        @PrecioUnit, 
        @Descuento, 
        @Subtotal;
    RETURN @Resultado;
END
GO

-- Función para actualizar detalle de producto en venta
CREATE FUNCTION dbo.fn_ActualizarDetalleProductoVenta
(
    @DetalleID INT,
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = ActualizarDetalleProductoVenta 
        @DetalleID, 
        @VentaID, 
        @ProductoID, 
        @Cantidad, 
        @PrecioUnit, 
        @Descuento, 
        @Subtotal;
    RETURN @Resultado;
END
GO

-- Función para eliminar detalle de producto en venta
CREATE FUNCTION dbo.fn_EliminarDetalleProductoVenta
(
    @DetalleID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = EliminarDetalleProductoVenta @DetalleID;
    RETURN @Resultado;
END
GO

-- Función para consultar detalles de productos en venta
CREATE FUNCTION dbo.fn_ConsultarDetallesProductoVenta()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM DetalleProductoVenta
);
GO

-- Función para insertar detalle de servicio en venta
CREATE FUNCTION dbo.fn_InsertarDetalleServicioVenta
(
    @VentaID INT,
    @ServicioID INT,
    @Cantidad INT,
    @PrecioUnit DECIMAL(10, 2),
    @Descuento DECIMAL(10, 2),
    @Subtotal DECIMAL(10, 2)
)
RETURNS INT
AS
BEGIN
    DECLARE @Resultado INT;
    EXEC @Resultado = InsertarDetalleServicioVenta 
        @VentaID, 
        @ServicioID, 
        @Cantidad, 
        @PrecioUnit, 
        @Descuento, 
        @Subtotal;
    RETURN @Resultado;
END
GO

--TRIGGERS
-- Crear el trigger
 
--trigger para actualizar el estado de la venta
CREATE TRIGGER ActualizarEstadoVentaProducto
ON DetalleProductoVenta
AFTER INSERT
AS
BEGIN
    DECLARE @VentaID INT;
    SELECT @VentaID = VentaID FROM inserted;
 
    UPDATE Ventas
    SET Estado = 'En proceso'
    WHERE VentaID = @VentaID;
END
GO
 
--Trigger para actualizar el estado de la venta al insertar un detalle de servicio
CREATE TRIGGER ActualizarEstadoVentaServicio
ON DetalleServicioVenta
AFTER INSERT
AS
BEGIN
    DECLARE @VentaID INT;
    SELECT @VentaID = VentaID FROM inserted;
 
    UPDATE Ventas
    SET Estado = 'En proceso'
    WHERE VentaID = @VentaID;
END
GO
 
--Trigger para actualizar el estado de la venta al eliminar un detalle de producto
CREATE TRIGGER ActualizarEstadoVentaProducto_Eliminar
ON DetalleProductoVenta
AFTER DELETE
AS
BEGIN
    DECLARE @VentaID INT;
    SELECT @VentaID = VentaID FROM deleted;
 
    IF NOT EXISTS (SELECT 1 FROM DetalleProductoVenta WHERE VentaID = @VentaID)
    BEGIN
        UPDATE Ventas
        SET Estado = 'Cancelada'
        WHERE VentaID = @VentaID;
    END
END
GO
 
--Trigger para actualizar el estado de la venta al eliminar un detalle de servicio
CREATE TRIGGER ActualizarEstadoVentaServicio_Eliminar
ON DetalleServicioVenta
AFTER DELETE
AS
BEGIN
    DECLARE @VentaID INT;
    SELECT @VentaID = VentaID FROM deleted;
 
    IF NOT EXISTS (SELECT 1 FROM DetalleServicioVenta WHERE VentaID = @VentaID)
    BEGIN
        UPDATE Ventas
        SET Estado = 'Cancelada'
        WHERE VentaID = @VentaID;
    END
END
GO
 
--Trigger para Actualizar Monto Total en DetalleProductoVenta
-- Trigger para actualizar el monto total cuando se inserta, actualiza o elimina un detalle de producto en una venta
CREATE OR ALTER TRIGGER trg_ActualizarMontoTotal_ProductoVenta
ON DetalleProductoVenta
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @VentaID INT;
    DECLARE @MontoTotal DECIMAL(10, 2);
 
    -- Obtener el ID de la venta afectada
    SELECT @VentaID = VentaID FROM inserted;
 
    -- Calcular el nuevo monto total sumando los subtotales de todos los detalles de productos de la venta
    SELECT @MontoTotal = COALESCE(SUM(Subtotal), 0) FROM DetalleProductoVenta WHERE VentaID = @VentaID;
 
    -- Actualizar el monto total en la tabla Ventas
    UPDATE Ventas SET MontoTotal = @MontoTotal WHERE VentaID = @VentaID;
END
GO
 
 
--Trigger para Actualizar Monto Total en DetalleServicioVenta:sql
-- Trigger para actualizar el monto total cuando se inserta, actualiza o elimina un detalle de servicio en una venta
CREATE OR ALTER TRIGGER trg_ActualizarMontoTotal_ServicioVenta
ON DetalleServicioVenta
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @VentaID INT;
    DECLARE @MontoTotal DECIMAL(10, 2);
 
    -- Obtener el ID de la venta afectada
    SELECT @VentaID = VentaID FROM inserted;
 
    -- Calcular el nuevo monto total sumando los subtotales de todos los detalles de servicios de la venta
    SELECT @MontoTotal = COALESCE(SUM(Subtotal), 0) FROM DetalleServicioVenta WHERE VentaID = @VentaID;
 
    -- Actualizar el monto total en la tabla Ventas
    UPDATE Ventas SET MontoTotal = @MontoTotal WHERE VentaID = @VentaID;
END
GO
 
INSERT INTO DetalleProductoVenta (VentaID,ProductoID, Cantidad, PrecioUnit, Descuento, Subtotal)
VALUES (1,5,1 , 10.50, 0.00, 10.00);
SELECT * FROM Ventas

select * from DetalleProductoVenta

