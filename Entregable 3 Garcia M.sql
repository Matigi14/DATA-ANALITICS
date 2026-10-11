/*Creamos la base de datos*/
CREATE DATABASE Ventas_Tech_DB;

--La colocamos en uso
USE Ventas_Tech_DB;

/*Eliminamos posibles tablas creadas*/

DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Categorias;

/*Crearemos las tablase correspondientes*/
CREATE TABLE Categoria (
							IDCategoria INT PRIMARY KEY,
							NombreCategoria VARCHAR (50) NOT NULL,
							Descripcion VARCHAR (100)
						);

CREATE TABLE Clientes (
						IDCLiente INT PRIMARY KEY,
						Nombre VARCHAR (100) NOT NULL,
						Email VARCHAR (100) UNIQUE,
						Ciudad VARCHAR (50),
						FechaRegistro DATE NOT NULL
						);

CREATE TABLE Productos (
						IDProducto INT PRIMARY KEY,
						NombreProducto VARCHAR	(100) NOT NULL,
						IDCategoria INT 
						FOREIGN KEY REFERENCES Categoria (IDCategoria),
						Precio DECIMAL (10,2) NOT NULL,
						Stock INT DEFAULT 0,
						Activo BIT DEFAULT 1
						);

CREATE TABLE Ventas (
						IDVenta INT PRIMARY KEY,
						IDCliente INT FOREIGN KEY REFERENCES Clientes (IDCLiente),
						IDProducto INT FOREIGN KEY REFERENCES Productos (IDProducto),
						Cantidad INT NOT NULL,
						PrecioUnitario DECIMAL (10,2) NOT NULL,
						FechaVenta DATE NOT NULL
						);

/*Insertamos Datos*/

INSERT INTO dbo.Categoria (IDCategoria,NombreCategoria,Descripcion) VALUES
(1,'Computación','Laptosps,PCs y monitores'),
(2,'Accesorios','Periféricos y complementos'),
(3,'Audio','Auriculares y parlantes'),
(4,'Almacenamiento','Discos y memorias');

INSERT INTO dbo.Clientes (IDCLiente,Nombre,Email,Ciudad,FechaRegistro) VALUES
(1,'María López','maria@mail.com','Buenos Aires','2024-01-05'),
(2,'Carlos Ruiz','carlos@mail.com','Córdoba','2024-01-10'),
(3,'Ana Gómez','ana@mail.com','Rosario','2024-02-01'),
(4,'Pedro Sanz','pedro@mail.com','Mendoza','2024-02-15'),
(5,'Laura Torres','laura@mail.com','Tucumán','2024-03-01');

INSERT INTO dbo.Productos (IDProducto,NombreProducto,IDCategoria,Precio,Stock,Activo) VALUES
(1,'Laptop Pro 15',1,1200.00,15,1),
(2,'Mouse Inalámbrico',2,28.00,80,1),
(3,'Monitor 4K 27',1,450.00,12,1),
(4,'Auriculares BT Pro',3,120.00,35,1),
(5,'SSD Externo 1TB',4,130.00,18,1),
(6,'Teclado Mecánico',2,95.00,40,1);

INSERT INTO dbo.Ventas (IDVenta,IDCliente,IDProducto,Cantidad,PrecioUnitario,FechaVenta) VALUES
(1,1,1,2,1200.00,'2024-03-05'),
(2,2,2,5,28.00,'2024-03-06'),
(3,3,3,1,450.00,'2024-03-07'),
(4,1,4,2,120.00,'2024-03-08'),
(5,4,5,3,130.00,'2024-03-10'),
(6,2,6,4,95.00,'2024-03-11'),
(7,5,1,1,1200.00,'2024-03-12'),
(8,3,2,8,28.00,'2024-03-13'),
(9,4,4,1,120.00,'2024-03-14'),
(10,5,3,2,450.00,'2024-03-15');

SELECT *
FROM dbo.Categoria;

SELECT *
FROM dbo.Clientes;

SELECT *
FROM dbo.Productos;

SELECT *
FROM dbo.Ventas;
