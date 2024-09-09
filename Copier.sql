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



--Actualizar el estado de la venta
UPDATE Ventas
SET Estado = 'Entregado'
WHERE VentaID = 'ID_de_la_venta'; --Aqui poner VentaID a actualizar (debe ser int)

