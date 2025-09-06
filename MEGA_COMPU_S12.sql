-- UNIVERSIDAD ESTATAL AMAZONICA
-- DENISIS PORTILLA
-- MEGACOMPU GESTION DE INVENTARIOS
CREATE DATABASE IF NOT EXISTS megacompu_gestion_inventario12;
USE megacompu_gestion_inventario12;



CREATE TABLE proveedor (
    id_proveedor int AUTO_INCREMENT,
    nombre_proveedor varchar(100),
    telefono varchar(20),
    direccion varchar(200),
    PRIMARY KEY (id_proveedor)
);

CREATE TABLE empleado (
    id_empleado int AUTO_INCREMENT,
    nombres varchar(100),
    apellidos varchar(100),
    cargo varchar(150),
    telefono varchar(15),
    PRIMARY KEY (id_empleado)
);

CREATE TABLE cliente (
    id_cliente int AUTO_INCREMENT,
    nombre varchar(100),
    telefono varchar(20),
    direccion varchar(200),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE producto (
    id_producto int AUTO_INCREMENT,
    nombre_producto varchar(100),
    precio decimal(10,2),
    stock int,
    PRIMARY KEY (id_producto)
);


CREATE TABLE factura_compra (
    id_facturacompra int AUTO_INCREMENT,
    fecha date,
    subtotal decimal(10,2),
    iva decimal(10,2),
    total decimal(10,2),
    id_proveedor int,
    id_empleado int,
    PRIMARY KEY (id_facturacompra),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);


create table detalle_compra_producto (
	id_detalle_compra int auto_increment,
	cantidad int,
	precio decimal(10,2),
    subtotal decimal(10,2),
    descuento decimal(10,2),
    iva decimal(10,2),
    id_facturacompra int,
    id_producto int,
    primary key (id_detalle_compra),
    FOREIGN KEY (id_facturacompra) REFERENCES factura_compra(id_facturacompra),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);


create table factura_venta (
	id_facturaventa int auto_increment,
	fecha date,
	subtotal decimal(10,2),
    iva decimal(10,2),
    total decimal(10,2),
    id_cliente int,
    id_empleado int,
    primary key (id_facturaventa),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)	
);


create table detalle_venta_producto(
	id_detalle_venta int auto_increment,
    cantidad int,
    precio decimal(10,2),
    subtotal decimal(10,2),
    id_producto int,
    id_facturaventa int,
    primary key (id_detalle_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_facturaventa) REFERENCES factura_venta(id_facturaventa)
);




insert into empleado values
	(1, 'DenisiS','Portilla', 'Administradora', '0982723301'),
	(2, 'Andrea', 'Ramirez','Vendedor', '09922334411' ),
	(3, 'Derlyn', 'Aguinda', 'Cajera', '094821490');


insert into cliente values
	(1, 'Pedro Sánchez', '0998123456', 'Av. Quito 123'),
	(2, 'Lucía Vargas', '0987654321', 'Calle Bolívar 456'),
	(3, 'Miguel Castro', '0981112233', 'Av. Amazonas 789'),
	(4, 'Fernanda Ruiz', '0976543210', 'Calle Sucre 321');


insert into producto values
	(1, 'Laptop Lenovo', 750.00, 15),
	(2, 'Mouse Logitech', 25.00, 50),
	(3, 'Teclado Mecánico Redragon', 60.00, 30),
	(4, 'Monitor Samsung 24”', 180.00, 20),
	(5, 'Disco Duro 1TB Seagate', 90.00, 40),
	(6, 'Impresora HP Deskjet 2700', 120.00, 10);


insert into Proveedor values
	(1, 'Importadora Computronic', '0998123456', 'Quito, Av. Amazonas y Colón'),
	(2, 'MegaTech Guayaquil', '0987654321', 'Guayaquil, Cdla. Alborada'),
	(3, 'Andes Distribuciones', '0981112233', 'Cuenca, Av. Solano'),
	(4, 'Ecuatech Loja', '0976543210', 'Loja, Av. Universitaria'),
	(5, 'TecnoAmazonía Orellanae', '0989988776', 'El Coca, Av. Quito y Esmeraldas');
	


insert into factura_Compra values
	(1, '2025-08-01', 1500.00, 225.00, 1725.00, 1, 1),
	(2, '2025-08-05', 900.00, 135.00, 1035.00, 2, 2);


INSERT INTO factura_Venta VALUES
	(1, '2025-08-10', 300.00, 45.00, 345.00, 1, 2),
	(2, '2025-08-15', 450.00, 67.50, 517.50, 2, 3),
	(3, '2025-08-20', 600.00, 90.00, 690.00, 3, 1),
	(4, '2025-08-27', 800.00, 120.00, 920.00, 4, 2),
	(5, '2025-09-22', 1000.00, 150.00, 1150.00, 1, 3);


select * from factura_venta
select * from factura_Compra
select * from detalle_compra_producto
select * from producto

update factura_venta 
set fecha = '2025-08-15'
where id_facturaventa = 4;

update factura_venta 
set id_empleado = 2
where id_facturaventa = 1;


INSERT INTO detalle_compra_producto VALUES
	(1, 10, 75.00, 750.00, 0.00, 112.50, 1,5),
	(2, 5, 150.00, 750.00, 0.00, 112.50, 1, 4),
	(3, 20, 45.00, 900.00, 0.00, 135.00, 2, 2);

select * from detalle_compra_producto

INSERT INTO detalle_venta_producto VALUES
	(1, 2, 90.00, 180.00, 5, 1),
	(2, 1, 120.00, 120.00, 6, 1),
	(3, 3, 150.00, 450.00, 1, 2);

-- TAREA SEMANA 12
-- FUNCIONES DE AGREGADO

-- Total de ventas realizas por un empleado específico
SELECT e.nombres, e.apellidos, SUM(fv.total) AS total_vendido
FROM Factura_Venta fv
JOIN Empleado e ON fv.id_empleado = e.id_empleado
WHERE e.id_empleado = 2
GROUP BY e.nombres, e.apellidos;


-- Promedio de precios solo de productos con precio mayor a $100
SELECT AVG(precio) AS Promedio_precio
FROM Producto
WHERE precio > 100;



-- SUBCONSULTA
-- Productos cuyo precio es superior al promedio de todos los productos.
SELECT nombre_producto, precio
FROM Producto
WHERE precio > (
    SELECT AVG(precio) 
    FROM Producto
);








