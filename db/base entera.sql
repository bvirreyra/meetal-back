-- Crear la base de datos
CREATE DATABASE meetal;
GO

USE meetal;
GO

-- Tabla Categorías
CREATE TABLE categoria (
    categoria_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NULL
);
GO
-- Tabla Subcategorías
CREATE TABLE subcategoria (
    subcategoria_id INT PRIMARY KEY IDENTITY(1,1),
    categoria_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NULL,
    CONSTRAINT FK_subcategoria_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
        ON DELETE CASCADE
);
GO
-- Tabla Productos
CREATE TABLE producto (
    producto_id INT PRIMARY KEY IDENTITY(1,1),
    subcategoria_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NULL,
    precio DECIMAL(10, 2) NOT NULL CHECK (Precio > 0),
    stock INT NOT NULL CHECK (Stock >= 0),
    CONSTRAINT FK_producto_subcategoria FOREIGN KEY (subcategoria_id) REFERENCES subcategoria(subcategoria_id)
        ON DELETE CASCADE
);
GO
-- Tabla Usuarios
CREATE TABLE cliente (
    cliente_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(255) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL
);
GO
-- Tabla Carrito
CREATE TABLE carrito (
    carrito_id INT PRIMARY KEY IDENTITY(1,1),
    usuario_id INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_carrito_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id)
        ON DELETE CASCADE
);
GO
-- Tabla DetalleCarrito
CREATE TABLE detalle_carrito (
    detalle_carrito_id INT PRIMARY KEY IDENTITY(1,1),
    carrito_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
	precio_unidad DECIMAL(6,2) NOT NULL,
    CONSTRAINT FK_detalle_carrito_carrito FOREIGN KEY (carrito_id) REFERENCES dbo.carrito(carrito_id)
        ON DELETE CASCADE,
    CONSTRAINT FK_detalle_carrito_producto FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
        ON DELETE CASCADE
);
GO
------ INSERTS ------------------------
INSERT INTO categoria (nombre, descripcion)
VALUES 
    ('Alimentos', 'Productos comestibles en general'),
    ('Bebidas', 'Bebidas alcohólicas y no alcohólicas'),
    ('Lácteos', 'Productos lácteos y derivados'),
    ('Carnes', 'Carne de res, cerdo, pollo y pescado'),
    ('Granos y Cereales', 'Arroz, quinua, maíz y otros cereales'),
    ('Aseo Personal', 'Productos para el cuidado personal'),
    ('Limpieza', 'Productos de limpieza para el hogar'),
    ('Mascotas', 'Alimentos y accesorios para mascotas'),
    ('Snacks', 'Snacks y golosinas'),
    ('Panadería', 'Productos de panadería y pastelería');
GO
--- Alimentos
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (1, 'Arroz y Fideos', 'Productos a base de cereales'),
    (1, 'Aceites y Grasas', 'Aceites y otros productos grasos'),
    (1, 'Conservas', 'Productos enlatados y conservas'),
    (1, 'Sopas y Caldos', 'Sopas, caldos y salsas listas'),
    (1, 'Especias y Condimentos', 'Especias y productos para condimentar');
GO
--- Bebidas
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (2, 'Gaseosas', 'Bebidas carbonatadas'),
    (2, 'Jugos', 'Jugos naturales y envasados'),
    (2, 'Cerveza', 'Cerveza y otras bebidas alcohólicas ligeras'),
    (2, 'Agua', 'Agua mineral y purificada'),
    (2, 'Energizantes', 'Bebidas energéticas y deportivas');
GO
--- Lácteos
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (3, 'Leche', 'Leche entera, deslactosada y saborizada'),
    (3, 'Yogures', 'Yogures naturales y saborizados'),
    (3, 'Quesos', 'Quesos frescos y maduros'),
    (3, 'Mantequilla y Margarina', 'Productos para untar'),
    (3, 'Postres Lácteos', 'Flanes, pudines y otros postres lácteos');
GO
--- Carnes
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (4, 'Res', 'Cortes de carne de res'),
    (4, 'Cerdo', 'Carne de cerdo fresca y procesada'),
    (4, 'Pollo', 'Cortes y productos a base de pollo'),
    (4, 'Pescados', 'Pescados frescos y congelados'),
    (4, 'Mariscos', 'Camarones, calamares y otros mariscos');
GO
--- Granos y Cereales
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (5, 'Arroz', 'Variedades de arroz'),
    (5, 'Quinua', 'Quinua en grano y procesada'),
    (5, 'Maíz', 'Maíz en grano y derivados'),
    (5, 'Avena', 'Avena en hojuelas y procesada'),
    (5, 'Legumbres', 'Frijoles, lentejas y otros');
GO
--- Aseo Personal
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (6, 'Shampoo y Acondicionadores', 'Productos para el cuidado del cabello'),
    (6, 'Cuidado Bucal', 'Pasta dental, enjuagues y accesorios'),
    (6, 'Jabones', 'Jabones líquidos y en barra'),
    (6, 'Desodorantes', 'Antitranspirantes y desodorantes'),
    (6, 'Cuidado de la Piel', 'Cremas, lociones y protectores solares');
GO
--- Limpieza
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (7, 'Detergentes', 'Detergentes para ropa y multiusos'),
    (7, 'Desinfectantes', 'Líquidos y aerosoles para desinfección'),
    (7, 'Lavaplatos', 'Productos para limpieza de utensilios'),
    (7, 'Limpia Vidrios', 'Productos para limpieza de cristales y ventanas'),
    (7, 'Papel y Toallas', 'Papel higiénico y toallas de cocina');
GO
--- Mascotas
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (8, 'Alimento para Perros', 'Croquetas, latas y suplementos'),
    (8, 'Alimento para Gatos', 'Croquetas, latas y suplementos'),
    (8, 'Accesorios', 'Correas, camas y juguetes'),
    (8, 'Higiene', 'Arenas y productos de limpieza para mascotas'),
    (8, 'Snacks', 'Premios y golosinas para mascotas');
GO
--- Snacks
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (9, 'Galletas', 'Galletas dulces y saladas'),
    (9, 'Chocolates', 'Chocolates y bombones'),
    (9, 'Chips', 'Papitas y otros snacks salados'),
    (9, 'Frutos Secos', 'Nueces, almendras y mix saludables'),
    (9, 'Barritas', 'Barritas energéticas y de cereales');
GO
--- Panadería
INSERT INTO subcategoria (categoria_id, nombre, descripcion)
VALUES 
    (10, 'Panes', 'Panes frescos y especiales'),
    (10, 'Tortas', 'Tortas, queques y pasteles'),
    (10, 'Galletas de Panadería', 'Productos horneados frescos'),
    (10, 'Masas y Bollería', 'Croissants, empanadas y otros'),
    (10, 'Postres', 'Postres elaborados y artesanales');
GO
-- "Arroz y Fideos"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (1, 'Arroz 1 kg', 'Arroz grano largo, 1 kg', 7.50, 50),
    (1, 'Fideo Tallarín 500 g', 'Fideo tallarín marca Don Vittorio, 500 g', 9.80, 30),
    (1, 'Arroz Integral 1 kg', 'Arroz integral saludable, 1 kg', 12.00, 40),
    (1, 'Fideo Spaghetti 500 g', 'Fideo spaghetti marca La Suprema, 500 g', 8.90, 35),
    (1, 'Arroz Parbolizado 1 kg', 'Arroz parbolizado, 1 kg', 10.50, 25);
GO
-- "Aceites y Grasas"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (2, 'Aceite de Girasol 1 lt', 'Aceite marca Fino, 1 litro', 18.00, 60),
    (2, 'Aceite de Oliva 500 ml', 'Aceite de oliva extra virgen, 500 ml', 45.00, 20),
    (2, 'Manteca Vegetal 1 kg', 'Manteca vegetal marca Regia, 1 kg', 23.50, 15),
    (2, 'Spray Antiadherente 200 ml', 'Spray antiadherente para cocinar', 30.00, 10),
    (2, 'Margarina 500 g', 'Margarina sin sal, 500 g', 15.00, 25);
GO
-- "Conservas"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (3, 'Atún en Lata 170 g', 'Atún en aceite, 170 g', 12.00, 100),
    (3, 'Duraznos en Almíbar 1 lt', 'Duraznos en almíbar, 1 litro', 18.50, 30),
    (3, 'Choclo en Conserva 300 g', 'Choclo tierno en conserva, 300 g', 9.90, 40),
    (3, 'Pimientos en Conserva 400 g', 'Pimientos rojos en conserva, 400 g', 14.00, 20),
    (3, 'Sardinas en Salsa 125 g', 'Sardinas en salsa de tomate, 125 g', 8.50, 50);
GO
-- "Sopas y Caldos"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (4, 'Sopa Instantánea Pollo', 'Sopa instantánea sabor pollo, 60 g', 3.50, 100),
    (4, 'Cubo de Caldo Res 10 un', 'Cubo de caldo sabor res, paquete de 10', 7.50, 50),
    (4, 'Crema de Espárragos', 'Sopa crema de espárragos, 500 g', 20.00, 15),
    (4, 'Sopa Instantánea Carne', 'Sopa instantánea sabor carne, 60 g', 3.50, 80),
    (4, 'Caldillo de Pollo', 'Caldillo de pollo en sobre, 75 g', 5.00, 70);
GO
-- "Especias y Condimentos"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (5, 'Sal yodada 1 kg', 'Sal yodada fina, 1 kg', 4.50, 200),
    (5, 'Pimienta Molida 50 g', 'Pimienta molida negra, 50 g', 6.90, 50),
    (5, 'Ajo en Polvo 100 g', 'Ajo en polvo deshidratado, 100 g', 12.00, 40),
    (5, 'Comino Molido 50 g', 'Comino molido fresco, 50 g', 5.90, 60),
    (5, 'Orégano Seco 50 g', 'Orégano seco, 50 g', 7.50, 50);
GO
-- "Shampoo y Acondicionadores"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (6, 'Shampoo Anticaspa 400 ml', 'Shampoo anticaspa marca Head & Shoulders, 400 ml', 35.00, 50),
    (6, 'Acondicionador Hidratante 300 ml', 'Acondicionador para cabello seco, 300 ml', 28.00, 40),
    (6, 'Shampoo Natural 500 ml', 'Shampoo con ingredientes naturales, 500 ml', 32.00, 30),
    (6, 'Acondicionador 2 en 1', 'Shampoo y acondicionador 2 en 1, 400 ml', 36.00, 25),
    (6, 'Shampoo para Niños 350 ml', 'Shampoo suave sin lágrimas, 350 ml', 22.00, 60);
GO
-- "Detergentes"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (7, 'Detergente en Polvo 1 kg', 'Detergente en polvo para ropa, 1 kg', 18.00, 70),
    (7, 'Detergente Líquido 900 ml', 'Detergente líquido concentrado, 900 ml', 25.00, 50),
    (7, 'Jabón Líquido Multiusos 500 ml', 'Jabón líquido para superficies, 500 ml', 14.00, 100),
    (7, 'Detergente para Ropa Negra 1 lt', 'Detergente especial para ropa negra, 1 lt', 30.00, 40),
    (7, 'Detergente en Cápsulas 20 un', 'Detergente en cápsulas para lavadoras, paquete de 20', 42.00, 20);
GO
-- "Alimento para Perros"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (8, 'Croquetas para Adultos 3 kg', 'Croquetas para perros adultos, 3 kg', 95.00, 30),
    (8, 'Croquetas para Cachorros 1.5 kg', 'Croquetas especiales para cachorros, 1.5 kg', 60.00, 50),
    (8, 'Comida Húmeda en Lata 400 g', 'Alimento húmedo para perros, 400 g', 22.00, 100),
    (8, 'Snacks de Pollo 200 g', 'Snacks de pollo deshidratado, 200 g', 40.00, 25),
    (8, 'Croquetas para Razas Pequeñas 2 kg', 'Croquetas para perros de razas pequeñas, 2 kg', 75.00, 40);
GO
-- "Chocolates"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (9, 'Chocolate en Barra 100 g', 'Chocolate semiamargo en barra, 100 g', 12.00, 60),
    (9, 'Bombones de Chocolate 200 g', 'Bombones rellenos de licor, 200 g', 45.00, 30),
    (9, 'Chocolate Blanco 150 g', 'Chocolate blanco con almendras, 150 g', 18.00, 50),
    (9, 'Cacao en Polvo 500 g', 'Cacao en polvo para bebidas y postres, 500 g', 35.00, 25),
    (9, 'Chocolate con Leche 100 g', 'Chocolate con leche clásico, 100 g', 10.00, 80);
GO
-- "Panes"
INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
VALUES
    (10, 'Pan de Molde Blanco 500 g', 'Pan de molde blanco, 500 g', 12.00, 100),
    (10, 'Pan Integral 400 g', 'Pan integral con semillas, 400 g', 15.00, 80),
    (10, 'Pan de Batalla 1 un', 'Pan de batalla fresco, unidad', 1.50, 200),
    (10, 'Pan Baguette 250 g', 'Pan baguette estilo francés, 250 g', 8.00, 50),
    (10, 'Pan Hamburguesa 6 un', 'Pan para hamburguesas, paquete de 6', 14.00, 60);
GO
-- Insertar usuario para el carrito
INSERT INTO usuario (nombre, correo, contraseña)
VALUES ('Juan López', 'juan.lopez@gmail.com', 'juan123');
GO
-- Crear un carrito para el usuario
INSERT INTO carrito (usuario_id)
VALUES (1);
GO
-- Agregar un producto al carrito
INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio_unidad)
VALUES (1, 1,2,7.50); -- Aquí se agrega 2 unidades del producto con producto_id = 1
GO

select * from cliente

select dc.*, (cantidad*precio_unidad) total_producto from carrito c 
JOIN detalle_carrito dc ON c.carrito_id=dc.carrito_id