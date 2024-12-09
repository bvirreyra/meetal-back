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
    pass VARCHAR(100) NOT NULL
);
GO
-- Tabla Carrito
CREATE TABLE carrito (
    carrito_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_carrito_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
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

------------------------------------- INSERTS -------------------------------------------
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
    -- Subcategoría: Arroz y Fideos
(1, 'Arroz Fino 5kg', 'Arroz blanco de grano largo Fino en bolsa de 5kg.', 40.00, 150),
(1, 'Fideo Don Vittorio 1kg', 'Fideos Don Vittorio tipo espagueti en paquete de 1kg.', 18.50, 200),
(1, 'Arroz Integral 1kg', 'Arroz integral orgánico en bolsa de 1kg.', 20.00, 120),
(1, 'Fideo Lucchetti Vermicelli', 'Fideo Lucchetti Vermicelli para sopas.', 15.00, 100),
(1, 'Arroz Perla 10kg', 'Bolsa de arroz Perla de 10kg para familias grandes.', 70.00, 80),
(1, 'Fideo Rigatti', 'Fideo tipo rigatti ideal para ensaladas.', 16.50, 150),
(1, 'Arroz Dorado', 'Arroz fortificado en bolsa de 2kg.', 30.00, 120),
(1, 'Fideo Lasagna', 'Fideo para lasagna, ideal para recetas italianas.', 25.00, 60),
(1, 'Arroz Chuncho', 'Variedad de arroz nativo en paquete de 2kg.', 35.00, 90),
(1, 'Fideo Macarrones', 'Fideo tipo macarrón para niños.', 17.50, 110),

-- Subcategoría: Aceites y Grasas
(2, 'Aceite Fino 1L', 'Aceite de cocina Fino en botella de 1L.', 18.00, 200),
(2, 'Margarina Delicia 500g', 'Margarina para cocina y repostería.', 15.00, 150),
(2, 'Aceite de Girasol', 'Aceite de girasol Ideal 1L.', 16.00, 170),
(2, 'Aceite Oliva Extra Virgen', 'Aceite de oliva extra virgen 500ml.', 45.00, 60),
(2, 'Grasa Vegetal 1kg', 'Grasa vegetal para panadería y frituras.', 25.00, 120),
(2, 'Aceite Mazola', 'Aceite Mazola para ensaladas y frituras.', 22.00, 130),
(2, 'Manteca Sol 1kg', 'Manteca de cerdo envasada 1kg.', 20.00, 100),
(2, 'Aceite Gourmet 500ml', 'Aceite gourmet con hierbas.', 55.00, 40),
(2, 'Margarina Regia', 'Margarina sabor mantequilla.', 18.00, 110),
(2, 'Aceite Palma', 'Aceite económico en botella de 2L.', 30.00, 90),

-- Subcategoría: Conservas
(3, 'Conserva de Atún', 'Atún en aceite vegetal 140g.', 12.00, 300),
(3, 'Sardinas Calvo', 'Lata de sardinas en salsa de tomate.', 14.00, 250),
(3, 'Duraznos en Almíbar', 'Conserva de duraznos en almíbar.', 18.50, 120),
(3, 'Maíz Dulce', 'Lata de maíz dulce en conserva.', 10.00, 200),
(3, 'Frutas Mixtas', 'Lata de frutas en almíbar.', 20.00, 80),
(3, 'Conserva de Espárragos', 'Espárragos en conserva.', 22.00, 70),
(3, 'Pulpa de Mango', 'Pulpa de mango en conserva.', 15.00, 90),
(3, 'Tomates Pelados', 'Lata de tomates pelados enteros.', 14.50, 140),
(3, 'Conserva de Almejas', 'Lata de almejas en agua salada.', 30.00, 50),
(3, 'Conserva de Champiñones', 'Champiñones enteros en conserva.', 16.00, 100),

-- Subcategoría: Sopas y Caldos
(4, 'Sopa de Pollo Maggi', 'Sopa instantánea de pollo Maggi.', 6.50, 200),
(4, 'Sopa de Verduras Knorr', 'Sopa instantánea de verduras Knorr.', 7.00, 180),
(4, 'Sopa de Gallina Nor', 'Sopa criolla con sabor a gallina.', 6.00, 160),
(4, 'Caldo de Costilla Maggi', 'Sopa con sabor a costilla Maggi.', 8.50, 150),
(4, 'Sopa de Quinua Andina', 'Sopa de quinua lista para servir.', 12.00, 100),
(4, 'Sopa Crema Champiñones', 'Sopa crema instantánea de champiñones.', 7.50, 140),
(4, 'Caldo de Res en Cubos', 'Cubos concentrados para caldo de res.', 4.00, 250),
(4, 'Sopa Minestrone Maggi', 'Sopa instantánea estilo italiano.', 8.00, 120),
(4, 'Sopa Crema de Tomate', 'Sopa crema de tomate lista para calentar.', 6.50, 180),
(4, 'Sopa de Maní Instantánea', 'Sopa de maní lista en minutos.', 10.00, 90),

-- Subcategoría: Especias y Condimentos
(5, 'Orégano Deshidratado', 'Bolsa de orégano deshidratado de 50g.', 5.00, 300),
(5, 'Comino en Polvo', 'Comino molido en frasco de 100g.', 6.00, 250),
(5, 'Pimienta Negra Molida', 'Pimienta negra molida en bolsa de 50g.', 8.50, 200),
(5, 'Ajo en Polvo', 'Ajo en polvo para condimentar.', 7.00, 180),
(5, 'Pimentón Dulce', 'Pimentón dulce molido en frasco.', 9.00, 160),
(5, 'Hierbas Finas', 'Mezcla de hierbas finas para sazonar.', 10.00, 140),
(5, 'Ají Molido', 'Ají rojo molido para sopas.', 12.00, 120),
(5, 'Condimento Completo Maggi', 'Condimento para carnes y sopas.', 15.00, 100),
(5, 'Azafrán Boliviano', 'Azafrán para paellas y arroces.', 25.00, 80),
(5, 'Canela en Rama', 'Canela en rama en paquete de 100g.', 6.00, 150),

-- Subcategoría: Gaseosas
(6, 'Coca Cola 2L', 'Refresco Coca Cola en botella de 2L.', 12.00, 500),
(6, 'Pepsi 2L', 'Refresco Pepsi en botella de 2L.', 11.50, 400),
(6, 'Fanta Naranja 2L', 'Refresco Fanta sabor naranja 2L.', 12.00, 300),
(6, 'Sprite 2L', 'Refresco Sprite en botella de 2L.', 11.50, 350),
(6, 'Guaraná Antarctica', 'Bebida gasificada sabor guaraná.', 14.00, 200),
(6, 'Seven Up', 'Refresco Seven Up 2L.', 12.50, 250),
(6, 'Coca Cola Sin Azúcar', 'Refresco sin azúcar Coca Cola.', 12.00, 300),
(6, 'Pepsi Light', 'Pepsi sin azúcar.', 11.50, 280),
(6, 'Mirinda', 'Refresco Mirinda de sabor naranja.', 10.00, 320),
(6, 'Fanta Uva', 'Refresco Fanta sabor uva.', 12.50, 200),

-- Subcategoría: Jugos
(7, 'Jugo Tampico 1L', 'Jugo de frutas mixtas Tampico.', 8.50, 400),
(7, 'Jugo Del Valle Durazno', 'Jugo Del Valle sabor durazno 1L.', 10.00, 350),
(7, 'Jugo Motts Manzana', 'Jugo de manzana Motts 1L.', 12.00, 300),
(7, 'Jugo Natura Naranja', 'Jugo Natura sabor naranja 1L.', 9.50, 400),
(7, 'Jugo Watts Frutas', 'Jugo Watts frutas tropicales.', 11.00, 250),
(7, 'Jugo Kern’s', 'Jugo de mango Kern’s 500ml.', 8.00, 300),
(7, 'Jugo DeliFrut Frutilla', 'Jugo de frutilla DeliFrut.', 10.50, 200),
(7, 'Jugo Tial', 'Jugo de maracuyá Tial.', 9.50, 220),
(7, 'Nectar Andina', 'Nectar de durazno marca Andina.', 8.00, 280),
(7, 'Jugo Jumex', 'Jugo de guayaba Jumex.', 9.00, 240),

-- Subcategoría: Cerveza
(8, 'Paceña 620ml', 'Cerveza tradicional boliviana.', 14.00, 500),
(8, 'Huari 620ml', 'Cerveza premium boliviana.', 15.00, 450),
(8, 'Bock 620ml', 'Cerveza oscura boliviana.', 13.50, 300),
(8, 'Potosina 1L', 'Cerveza de Potosí.', 10.00, 400),
(8, 'Ducal Lata', 'Cerveza ligera en lata.', 8.00, 350),
(8, 'Auténtica 620ml', 'Cerveza boliviana económica.', 11.50, 300),
(8, 'Cordillera Lata', 'Cerveza rubia boliviana.', 9.00, 320),
(8, 'Sureña 620ml', 'Cerveza artesanal.', 16.00, 250),
(8, 'Taquiña 620ml', 'Cerveza del Valle Cochabambino.', 12.50, 400),
(8, 'Real Lata', 'Cerveza en lata 350ml.', 7.50, 500),

-- Subcategoría: Agua
(9, 'Agua Vital 2L', 'Agua embotellada Vital.', 7.00, 600),
(9, 'Agua Natural Villa', 'Agua mineral natural 1.5L.', 6.00, 550),
(9, 'Agua Sin Gas Cielo', 'Agua sin gas en presentación 1L.', 5.50, 500),
(9, 'Agua Zenda 500ml', 'Agua embotellada Zenda.', 3.50, 800),
(9, 'Agua Manantial', 'Agua mineralizada 2L.', 8.50, 400),
(9, 'Agua San Luis', 'Agua purificada de mesa.', 6.00, 300),
(9, 'Agua Mineral Glacial', 'Agua con bajo contenido de sodio.', 5.00, 450),
(9, 'Agua Natural Cascada', 'Agua de mesa en presentación 1.5L.', 6.50, 500),
(9, 'Agua Sin Gas Laguna', 'Agua embotellada sin gas.', 5.50, 600),
(9, 'Agua Vital Kids', 'Agua purificada 300ml para niños.', 4.00, 700),

-- Subcategoría: Energizantes
(10, 'Vive 100', 'Energizante popular en Bolivia.', 6.50, 500),
(10, 'Monster Energy', 'Energizante con alto contenido de cafeína.', 10.00, 400),
(10, 'Red Bull', 'Energizante clásico.', 12.00, 350),
(10, 'Coca-Cola Energy', 'Energizante con sabor a cola.', 9.50, 300),
(10, 'Volt Energy Drink', 'Energizante económico.', 7.50, 450),
(10, 'Boost Energy', 'Bebida energizante de rápida acción.', 8.00, 300),
(10, 'Bacchus', 'Energizante en botella pequeña.', 6.00, 400),
(10, 'Force Energy', 'Energizante de larga duración.', 8.50, 250),
(10, 'Energy Hype', 'Energizante juvenil.', 9.00, 300),
(10, 'Rockstar Energy', 'Energizante de sabores frutales.', 11.50, 200),

-- Subcategoría: Leche
(11, 'Leche PIL Entera', 'Leche entera pasteurizada PIL.', 8.50, 700),
(11, 'Leche Soal Entera', 'Leche entera Soal.', 7.50, 650),
(11, 'Leche Lactisur Descremada', 'Leche descremada Lactisur.', 9.50, 600),
(11, 'Leche Delizia Saborizada', 'Leche sabor chocolate Delizia.', 10.00, 500),
(11, 'Leche Lactoland Entera', 'Leche boliviana de alta calidad.', 9.00, 550),
(11, 'Leche En Polvo PIL', 'Leche en polvo 400g.', 30.00, 300),
(11, 'Leche Parmalat', 'Leche importada UHT.', 12.00, 400),
(11, 'Leche Condensada Nestlé', 'Leche condensada Nestlé 397g.', 18.00, 350),
(11, 'Leche Evaporada Gloria', 'Leche evaporada en lata 410g.', 14.00, 400),
(11, 'Leche Zymil Sin Lactosa', 'Leche sin lactosa UHT.', 15.00, 200),

-- Subcategoría: Yogures
(12, 'Yogur PIL Fresa', 'Yogur sabor fresa 1L.', 16.00, 400),
(12, 'Yogur Delizia Durazno', 'Yogur sabor durazno 1L.', 15.00, 350),
(12, 'Yogur Soal Natural', 'Yogur natural sin azúcar.', 12.00, 300),
(12, 'Yogur Lactoland Fresa', 'Yogur boliviano con frutas.', 14.00, 450),
(12, 'Yogur Parmalat Frutos Rojos', 'Yogur importado.', 20.00, 200),
(12, 'Yogur Deslactosado PIL', 'Yogur para intolerantes a la lactosa.', 15.00, 300),
(12, 'Yogur Delizia Piña', 'Yogur con trozos de piña.', 16.00, 250),
(12, 'Yogur Griego PIL', 'Yogur estilo griego.', 18.00, 200),
(12, 'Yogur Bebible Soal', 'Yogur líquido con sabores variados.', 10.00, 500),
(12, 'Yogur Multifruta PIL', 'Yogur sabor multifruta.', 17.00, 350),

-- Subcategoría: Quesos
(13, 'Queso Edam', 'Queso semi-duro con un sabor suave y textura cremosa.', 35.00, 200),
(13, 'Queso Cheddar', 'Queso madurado de color amarillo y sabor fuerte.', 40.00, 250),
(13, 'Queso Gouda', 'Queso holandés de sabor dulce y textura firme.', 38.00, 300),
(13, 'Queso Mozzarella', 'Queso fresco ideal para pizzas y pastas.', 45.00, 350),
(13, 'Queso Parmesano', 'Queso duro con un sabor intenso y salado.', 60.00, 150),
(13, 'Queso Azul', 'Queso con vetas de moho azul y sabor característico.', 50.00, 100),
(13, 'Queso Brie', 'Queso francés de textura cremosa y corteza blanca.', 55.00, 200),
(13, 'Queso Camembert', 'Queso de sabor suave con una corteza comestible.', 53.00, 180),
(13, 'Queso Crema', 'Queso suave y untuoso ideal para postres.', 28.00, 400),
(13, 'Queso Manchego', 'Queso español con un sabor intenso.', 45.00, 250),

-- Subcategoría: Mantequilla y Margarina
(14, 'Mantequilla PIL Sin Sal', 'Mantequilla para cocinar.', 20.00, 300),
(14, 'Margarina Regia', 'Margarina económica.', 15.00, 400),
(14, 'Margarina Dorina', 'Margarina sabor mantequilla.', 16.00, 350),
(14, 'Margarina delizia', 'Margarina con vitaminas.', 18.00, 250),
(14, 'Margarina Light PIL', 'Margarina baja en calorías.', 17.00, 300),
(14, 'Mantequilla Con Sal PIL', 'Mantequilla tradicional.', 22.00, 200),
(14, 'Margarina en Barra Regia', 'Presentación práctica para cocinar.', 12.00, 400),
(14, 'Margarina La Campiña', 'Margarina con sabor a mantequilla.', 19.00, 300),
(14, 'Margarina Dorada', 'Margarina cremosa.', 15.00, 450),
(14, 'Margarina Sin Lactosa PIL', 'Para intolerantes a la lactosa.', 18.00, 200),

-- Subcategoría: Postres Lácteos
(15, 'Flan de Vainilla', 'Postre lácteo con sabor a vainilla y textura cremosa.', 12.00, 300),
(15, 'Arroz con Leche', 'Postre tradicional hecho con arroz y leche.', 10.00, 400),
(15, 'Yogur Griego con Frutas', 'Yogur natural con trozos de frutas.', 15.00, 350),
(15, 'Pudín de Chocolate', 'Postre lácteo de sabor a chocolate intenso.', 14.00, 250),
(15, 'Mousse de Maracuyá', 'Postre cremoso con sabor tropical.', 18.00, 200),
(15, 'Dulce de Leche en Vasos', 'Postre lácteo dulce y suave.', 16.00, 300),
(15, 'Postre de Gelatina con Crema', 'Postre frío con capas de gelatina y crema.', 12.50, 400),
(15, 'Natilla de Coco', 'Postre lácteo con un toque de coco.', 13.00, 350),
(15, 'Crema Volteada', 'Postre similar al flan con caramelo.', 15.00, 200),
(15, 'Quesillo de Leche', 'Postre de textura ligera y dulce.', 14.00, 250),

-- Subcategoría: Res
(16, 'Bife de Chorizo', 'Corte premium para parrilla.', 45.00, 150),
(16, 'Costilla de Res', 'Ideal para sopas y guisos.', 35.00, 200),
(16, 'Lomo Liso', 'Corte tierno para asados.', 50.00, 120),
(16, 'Carne Molida', 'Carne molida fresca.', 25.00, 300),
(16, 'Asado de Tira', 'Corte especial para parrillas.', 40.00, 100),
(16, 'Hígado de Res', 'Hígado fresco para guisos.', 20.00, 200),
(16, 'Chuleta de Res', 'Corte con hueso para asar.', 38.00, 180),
(16, 'Colita de Cuadril', 'Corte para hornear.', 48.00, 80),
(16, 'Rabo de Res', 'Ideal para sopas tradicionales.', 30.00, 90),
(16, 'Entrecot', 'Corte jugoso y tierno.', 55.00, 70),

-- Subcategoría: Cerdo
(17, 'Costillas de Cerdo', 'Corte de cerdo ideal para asados.', 48.00, 100),
(17, 'Chuleta de Cerdo', 'Corte clásico de cerdo con hueso.', 45.00, 150),
(17, 'Pierna de Cerdo', 'Corte grande ideal para hornear.', 55.00, 80),
(17, 'Lomo de Cerdo', 'Carne magra de cerdo.', 50.00, 120),
(17, 'Tocino Ahumado', 'Carne de cerdo curada y ahumada.', 38.00, 200),
(17, 'Chorizo de Cerdo', 'Embutido preparado con carne de cerdo.', 25.00, 300),
(17, 'Jamonada de Cerdo', 'Producto elaborado con carne de cerdo.', 30.00, 250),
(17, 'Pernil de Cerdo', 'Corte para preparaciones tradicionales.', 58.00, 90),
(17, 'Costillar de Cerdo', 'Ideal para parrilladas.', 50.00, 100),
(17, 'Carne Molida de Cerdo', 'Carne de cerdo procesada.', 35.00, 200),

-- Subcategoría: Pollo
(18, 'Pechuga de Pollo', 'Corte magro y versátil.', 38.00, 400),
(18, 'Alitas de Pollo', 'Corte ideal para parrillas o freír.', 25.00, 300),
(18, 'Muslo de Pollo', 'Corte con hueso y sabor intenso.', 30.00, 350),
(18, 'Pierna de Pollo', 'Corte ideal para guisos.', 28.00, 300),
(18, 'Carne Molida de Pollo', 'Carne procesada de pollo.', 32.00, 250),
(18, 'Pollo Entero', 'Ideal para hornear o asar.', 50.00, 100),
(18, 'Filete de Pollo', 'Corte sin hueso ni piel.', 42.00, 200),
(18, 'Menudencias de Pollo', 'Hígado, corazón y molleja.', 18.00, 300),
(18, 'Nuggets de Pollo', 'Producto procesado de carne de pollo.', 22.00, 400),
(18, 'Hamburguesa de Pollo', 'Carne preparada para hamburguesas.', 35.00, 200),

-- Subcategoría: Pescados
(19, 'Trucha del Titicaca', 'Pescado fresco de la región andina.', 35.00, 200),
(19, 'Filete de Pejerrey', 'Pescado sin espinas.', 30.00, 300),
(19, 'Salmón Importado', 'Pescado premium.', 60.00, 150),
(19, 'Atún en Lata PIL', 'Atún boliviano en aceite.', 18.00, 400),
(19, 'Bagre Entero', 'Pescado fresco.', 25.00, 200),
(19, 'Filete de Dorado', 'Pescado apto para freír.', 28.00, 250),
(19, 'Tilapia Fresca', 'Pescado tropical.', 22.00, 300),
(19, 'Corvina Entera', 'Pescado fresco de mar.', 40.00, 100),
(19, 'Atún Ahumado', 'Filete de atún con sabor especial.', 50.00, 200),
(19, 'Sardinas en Lata', 'Pescado conservado.', 10.00, 400),

-- Subcategoría: Mariscos
(20, 'Camarones Frescos', 'Camarones frescos para cocinar.', 70.00, 150),
(20, 'Calamares Enteros', 'Calamares frescos.', 55.00, 200),
(20, 'Mejillones Congelados', 'Mejillones listos para cocinar.', 40.00, 300),
(20, 'Pulpo Fresco', 'Pulpo de alta calidad.', 80.00, 100),
(20, 'Langostinos Jumbo', 'Langostinos frescos grandes.', 90.00, 150),
(20, 'Caracol de Mar', 'Caracol fresco para platillos especiales.', 60.00, 120),
(20, 'Cangrejo Azul', 'Cangrejo entero.', 85.00, 100),
(20, 'Almejas Frescas', 'Almejas ideales para sopas.', 50.00, 200),
(20, 'Mariscos Mixtos', 'Combinación de varios mariscos.', 75.00, 180),
(20, 'Langosta Entera', 'Langosta fresca premium.', 150.00, 50),

-- Subcategoría: Arroz
(21, 'Arroz Flor Blanca', 'Arroz blanco de grano largo.', 4.50, 500),
(21, 'Arroz Valencia', 'Arroz económico.', 3.80, 700),
(21, 'Arroz San Remo', 'Arroz de alta calidad.', 5.20, 400),
(21, 'Arroz Integral PIL', 'Arroz integral saludable.', 6.50, 300),
(21, 'Arroz El Ceibo', 'Arroz boliviano.', 4.00, 500),
(21, 'Arroz Jazmín', 'Arroz aromático.', 7.00, 250),
(21, 'Arroz Basmati', 'Arroz premium importado.', 9.50, 200),
(21, 'Arroz Dulce', 'Arroz ideal para postres.', 4.00, 400),
(21, 'Arroz Parbolizado', 'Arroz precocido.', 5.50, 300),
(21, 'Arroz Pilado', 'Arroz de grano partido.', 3.60, 600),

-- Subcategoría: Quinua
(22, 'Quinua Blanca', 'Grano de quinua ideal para ensaladas y guarniciones.', 22.00, 300),
(22, 'Quinua Roja', 'Variedad de quinua rica en antioxidantes.', 25.00, 250),
(22, 'Quinua Negra', 'Quinua con un sabor más intenso y alto valor nutritivo.', 28.00, 200),
(22, 'Harina de Quinua', 'Harina elaborada a partir de quinua.', 18.00, 300),
(22, 'Quinua Instantánea', 'Producto listo para consumir.', 20.00, 250),
(22, 'Quinua en Copos', 'Presentación en hojuelas para desayuno.', 24.00, 200),
(22, 'Barritas de Quinua', 'Snack saludable a base de quinua.', 15.00, 350),
(22, 'Bebida de Quinua', 'Bebida natural a base de quinua.', 10.00, 400),
(22, 'Quinua Saborizada', 'Granos de quinua con especias.', 22.00, 300),
(22, 'Quinua Orgánica', 'Grano cultivado sin químicos.', 30.00, 150),

-- Subcategoría: Maíz
(23, 'Maíz Amarillo', 'Maíz común para cocina y guarniciones.', 12.00, 400),
(23, 'Maíz Blanco', 'Variedad ideal para sopas y guisos.', 10.00, 350),
(23, 'Harina de Maíz', 'Producto procesado para preparar masas.', 8.00, 500),
(23, 'Maíz Choclo', 'Mazorca fresca para cocción.', 15.00, 300),
(23, 'Maíz Pisingallo', 'Variedad especial para pop-corn.', 18.00, 250),
(23, 'Maíz Tostado', 'Snack tradicional boliviano.', 20.00, 200),
(23, 'Chicha de Maíz', 'Bebida tradicional fermentada.', 22.00, 100),
(23, 'Mazorca de Maíz Congelado', 'Producto congelado para cocinar.', 14.00, 300),
(23, 'Polenta', 'Preparado a base de maíz molido.', 16.00, 250),
(23, 'Maíz Morado', 'Grano utilizado para bebidas y postres.', 25.00, 150),

-- Subcategoría: Avena
(24, 'Avena en Hojuelas', 'Producto integral para desayuno.', 8.00, 500),
(24, 'Avena Instantánea', 'Avena de rápida cocción.', 10.00, 400),
(24, 'Harina de Avena', 'Producto ideal para repostería.', 12.00, 300),
(24, 'Barritas de Avena', 'Snack saludable a base de avena.', 15.00, 350),
(24, 'Bebida de Avena', 'Leche vegetal hecha de avena.', 18.00, 300),
(24, 'Galletas de Avena', 'Producto horneado con avena.', 20.00, 250),
(24, 'Avena con Frutas', 'Hojuelas mezcladas con frutas deshidratadas.', 22.00, 300),
(24, 'Avena con Chía', 'Mezcla enriquecida con semillas de chía.', 24.00, 250),
(24, 'Avena Orgánica', 'Producto cultivado sin pesticidas.', 26.00, 200),
(24, 'Avena Saborizada', 'Avena con sabores añadidos como chocolate o vainilla.', 14.00, 400),

-- Subcategoría: Legumbres
(25, 'Lentejas', 'Legumbre rica en proteínas.', 12.00, 400),
(25, 'Garbanzos', 'Legumbre versátil para guisos y ensaladas.', 14.00, 350),
(25, 'Frijoles Negros', 'Legumbre común en sopas y guarniciones.', 10.00, 450),
(25, 'Frijoles Rojos', 'Legumbre tradicional para guisos.', 11.00, 400),
(25, 'Alverjas', 'Legumbre tierna y dulce.', 13.00, 300),
(25, 'Habas', 'Legumbre ideal para sopas.', 15.00, 250),
(25, 'Edamame', 'Vainas de soya verde.', 18.00, 200),
(25, 'Lentejas Amarillas', 'Variedad de lentejas con sabor suave.', 14.00, 350),
(25, 'Guisantes Secos', 'Legumbre deshidratada para cocinar.', 10.00, 400),
(25, 'Soja', 'Legumbre rica en nutrientes.', 16.00, 300),

-- Subcategoría: Shampoo y Acondicionadores
(26, 'Shampoo Sedal Brillo', 'Shampoo para cabello brillante.', 20.00, 300),
(26, 'Acondicionador Pantene', 'Acondicionador reparador.', 25.00, 250),
(26, 'Shampoo Dove Nutrición', 'Shampoo hidratante.', 22.00, 300),
(26, 'Acondicionador Tresemmé', 'Acondicionador profesional.', 28.00, 200),
(26, 'Shampoo Clear Anticaspa', 'Shampoo para caspa.', 18.00, 400),
(26, 'Shampoo Herbal Essences', 'Shampoo con ingredientes naturales.', 24.00, 200),
(26, 'Acondicionador Garnier Fructis', 'Acondicionador frutal.', 23.00, 250),
(26, 'Shampoo Johnson’s Baby', 'Shampoo para niños.', 15.00, 350),
(26, 'Shampoo Eucerin', 'Shampoo dermatológico.', 35.00, 100),
(26, 'Acondicionador L’Oréal', 'Acondicionador reparador.', 30.00, 150),

-- Subcategoría: Cuidado Bucal
(27, 'Pasta de Dientes', 'Pasta dental para el cuidado general de los dientes.', 8.00, 500),
(27, 'Cepillo de Dientes', 'Cepillo de dientes de cerdas suaves.', 5.00, 350),
(27, 'Hilo Dental', 'Hilo dental para limpieza entre dientes.', 3.00, 400),
(27, 'Enjuague Bucal', 'Enjuague bucal con sabor a menta.', 7.00, 300),
(27, 'Blanqueador Dental', 'Pasta de dientes para blanquear los dientes.', 12.00, 250),
(27, 'Cepillo Eléctrico', 'Cepillo de dientes eléctrico con 3 modos de cepillado.', 50.00, 150),
(27, 'Enjuague Bucal Antiséptico', 'Enjuague bucal con propiedades antisépticas.', 9.00, 350),
(27, 'Goma de Mascar', 'Goma de mascar para refrescar el aliento.', 2.00, 500),
(27, 'Limpia Lenguas', 'Herramienta para limpiar la lengua y eliminar bacterias.', 4.00, 300),
(27, 'Blanqueador Bucal', 'Producto para eliminar manchas y blanquear los dientes.', 10.00, 250),

-- Subcategoría: Jabones
(28, 'Jabón en Barra', 'Jabón de barra de uso diario para la higiene personal.', 4.00, 600),
(28, 'Jabón Líquido', 'Jabón líquido para manos y cuerpo.', 5.00, 500),
(28, 'Jabón Natural', 'Jabón natural elaborado con ingredientes orgánicos.', 6.00, 400),
(28, 'Jabón con Aloe Vera', 'Jabón con extracto de aloe vera para piel sensible.', 7.00, 350),
(28, 'Jabón Antibacterial', 'Jabón líquido antibacteriano para eliminar gérmenes.', 6.00, 300),
(28, 'Jabón en Barra para Niños', 'Jabón suave para la piel de los niños.', 4.50, 450),
(28, 'Jabón de Glicerina', 'Jabón de glicerina para hidratar la piel.', 5.00, 400),
(28, 'Jabón de Rosa Mosqueta', 'Jabón con extracto de rosa mosqueta para regenerar la piel.', 8.00, 350),
(28, 'Jabón Exfoliante', 'Jabón con partículas exfoliantes para eliminar células muertas.', 6.50, 300),
(28, 'Jabón Líquido para Bebés', 'Jabón suave y sin fragancia para la piel de los bebés.', 7.00, 250),

-- Subcategoría: Cuidado de la Piel
(29, 'Desodorante en Barra', 'Desodorante en barra de larga duración, con protección antitranspirante.', 5.00, 400),
(29, 'Desodorante Roll-On', 'Desodorante roll-on con propiedades antibacterianas y protección diaria.', 4.50, 350),
(29, 'Desodorante Aerosol', 'Desodorante en aerosol, ideal para todo el día.', 6.00, 300),
(29, 'Desodorante Natural', 'Desodorante natural sin químicos agresivos.', 7.00, 250),
(29, 'Desodorante Antitranspirante', 'Desodorante con protección contra el sudor y mal olor.', 5.50, 300),
(29, 'Desodorante para Hombre', 'Desodorante específico para la piel masculina.', 6.50, 250),
(29, 'Desodorante para Mujer', 'Desodorante para mujeres con fragancia floral y suave.', 6.00, 350),
(29, 'Desodorante Infantil', 'Desodorante suave y natural para niños y pieles sensibles.', 5.00, 300),
(29, 'Desodorante Herbal', 'Desodorante con extractos de hierbas para un cuidado más natural.', 7.50, 200),
(29, 'Desodorante Antibacterial', 'Desodorante con propiedades antibacterianas para pieles sensibles.', 6.00, 250),

-- Subcategoría: Cuidado de la Piel
(30, 'Crema Hidratante', 'Crema hidratante para piel seca.', 12.00, 300),
(30, 'Protector Solar', 'Protector solar con factor 50 para pieles sensibles.', 18.00, 250),
(30, 'Aceite para la Piel', 'Aceite corporal para mantener la piel suave.', 10.00, 350),
(30, 'Exfoliante Corporal', 'Exfoliante corporal con sales marinas y aceites naturales.', 15.00, 200),
(30, 'Crema Antiarrugas', 'Crema con efecto antiarrugas y rejuvenecedora.', 20.00, 150),
(30, 'Gel Calmante', 'Gel refrescante y calmante para después del sol.', 12.00, 300),
(30, 'Crema de Manos', 'Crema especial para manos secas y agrietadas.', 8.00, 400),
(30, 'Loción Corporal', 'Loción hidratante corporal para todo tipo de piel.', 10.00, 350),
(30, 'Crema para Pies', 'Crema hidratante para pies resecos y agrietados.', 9.00, 300),
(30, 'Mascarilla Facial', 'Mascarilla facial para nutrir y limpiar la piel del rostro.', 12.00, 250),

-- Subcategoría: Detergentes
(31, 'Omo Multiacción', 'Detergente para ropa.', 25.00, 400),
(31, 'Ace Naturals', 'Detergente en polvo.', 22.00, 350),
(31, 'Bolívar Lavado Fácil', 'Detergente boliviano.', 20.00, 500),
(31, 'Ariel Líquido', 'Detergente líquido.', 30.00, 300),
(31, 'Tide Pods', 'Detergente en cápsulas.', 35.00, 200),
(31, 'Detergente Persil', 'Detergente con tecnología avanzada.', 28.00, 250),
(31, 'Detergente Líquido Ace', 'Detergente líquido económico.', 26.00, 350),
(31, 'Detergente Ariel Polvo', 'Detergente clásico.', 20.00, 450),
(31, 'Detergente Élite', 'Detergente para ropa delicada.', 25.00, 300),
(31, 'Detergente Blanca Nieves', 'Detergente tradicional.', 18.00, 600),

-- Subcategoría: Desinfectantes
(32, 'Desinfectante en Spray', 'Desinfectante en spray para superficies, elimina bacterias y virus.', 4.50, 500),
(32, 'Desinfectante Líquido', 'Desinfectante líquido para uso doméstico en diferentes superficies.', 5.00, 400),
(32, 'Desinfectante en Gel', 'Gel desinfectante para manos, con acción rápida contra gérmenes.', 3.50, 350),
(32, 'Desinfectante Multiusos', 'Desinfectante concentrado para todo tipo de superficies.', 6.00, 300),
(32, 'Desinfectante en Toallitas', 'Toallitas desinfectantes para manos y superficies.', 4.00, 450),
(32, 'Desinfectante para Pisos', 'Desinfectante especializado para pisos y suelos.', 7.00, 250),
(32, 'Desinfectante con Fragancia', 'Desinfectante con fragancia agradable para ambientes y superficies.', 6.50, 300),
(32, 'Desinfectante para Baños', 'Desinfectante especial para áreas de baño, elimina gérmenes y malos olores.', 5.50, 350),
(32, 'Desinfectante Antibacterial', 'Desinfectante antibacterial que elimina el 99.9% de las bacterias.', 5.00, 400),
(32, 'Desinfectante Natural', 'Desinfectante con ingredientes naturales para un hogar saludable.', 8.00, 200),

-- Subcategoría: Lavaplatos
(33, 'Lavaplatos Líquido', 'Detergente líquido para lavar platos y utensilios.', 12.00, 300),
(33, 'Lavaplatos en Gel', 'Producto en gel concentrado para limpieza de platos.', 14.00, 250),
(33, 'Lavaplatos Eco', 'Lavaplatos con ingredientes naturales y amigables con el ambiente.', 16.00, 200),
(33, 'Lavaplatos con Limón', 'Producto con aroma a limón para una mejor frescura.', 10.00, 350),
(33, 'Lavaplatos Antibacterial', 'Lavaplatos que elimina bacterias y malos olores.', 15.00, 300),
(33, 'Lavaplatos en Barra', 'Presentación en barra para mayor durabilidad.', 13.00, 250),
(33, 'Lavaplatos en Pastillas', 'Pastillas concentradas para lavar platos a mano o en lavavajillas.', 18.00, 200),
(33, 'Lavaplatos con Aroma a Manzana', 'Producto con fragancia a manzana.', 12.00, 300),
(33, 'Lavaplatos en Espuma', 'Líquido que produce espuma para mayor eficacia en limpieza.', 17.00, 150),
(33, 'Lavaplatos Concentra', 'Lavaplatos con alta concentración para lavar más platos.', 14.00, 400),

-- Subcategoría: Limpia Vidrios
(34, 'Limpia Vidrios Tradicional', 'Producto básico para limpiar ventanas y superficies de vidrio.', 10.00, 300),
(34, 'Limpia Vidrios Con Esponja', 'Limpia vidrios con aplicador de esponja para mayor comodidad.', 12.00, 250),
(34, 'Limpia Vidrios sin Rayas', 'Limpia vidrios que deja superficies libres de rayas.', 15.00, 200),
(34, 'Limpia Vidrios con Fragancia', 'Limpia vidrios con fragancia fresca.', 13.00, 300),
(34, 'Limpia Vidrios Ecológico', 'Producto ecológico que no afecta el medio ambiente.', 18.00, 150),
(34, 'Limpia Vidrios Spray', 'Limpia vidrios en presentación de spray.', 11.00, 400),
(34, 'Limpia Vidrios Antihuellas', 'Producto que previene huellas en las superficies de vidrio.', 14.00, 250),
(34, 'Limpia Vidrios Multipropósito', 'Limpia vidrios que también sirve para otras superficies.', 16.00, 300),
(34, 'Limpia Vidrios Profesional', 'Producto ideal para uso profesional de limpieza de vidrios.', 20.00, 150),
(34, 'Limpia Vidrios Rápido', 'Producto que limpia vidrios de manera rápida y eficaz.', 12.00, 350),

-- Subcategoría: Papel y Toallas
(35, 'Papel Higiénico', 'Papel higiénico de 2 y 3 capas.', 6.00, 500),
(35, 'Toallas de Papel', 'Toallas absorbentes de papel para cocina.', 5.00, 450),
(35, 'Papel Toalla en Rollo', 'Rollo de papel toalla de alta calidad.', 8.00, 400),
(35, 'Papel de Cocina', 'Papel absorbente ideal para uso en la cocina.', 7.00, 500),
(35, 'Servilletas de Papel', 'Servilletas de papel desechables para comedor.', 4.00, 600),
(35, 'Papel Higiénico Doble', 'Papel higiénico de doble capa para mayor suavidad.', 9.00, 350),
(35, 'Papel Higiénico Familiar', 'Papel higiénico con más cantidad por paquete.', 10.00, 300),
(35, 'Papel Absorbente', 'Papel absorbente para uso general.', 6.00, 450),
(35, 'Toallas Desinfectantes', 'Toallas húmedas con desinfectante para manos.', 12.00, 250),
(35, 'Toalla de Papel Multicolor', 'Toalla de papel con varias opciones de colores.', 9.00, 350),

-- Subcategoría: Alimento para Perros
(36, 'Croquetas para Perro Adulto', 'Croquetas balanceadas para perros adultos.', 40.00, 300),
(36, 'Croquetas para Cachorros', 'Alimento para perros cachorros con nutrientes adicionales.', 35.00, 350),
(36, 'Comida Húmeda para Perro', 'Comida húmeda en lata para perros.', 50.00, 200),
(36, 'Snacks para Perros', 'Golosinas para perros de todas las edades.', 15.00, 400),
(36, 'Huesos para Perro', 'Huesos comestibles para perros.', 20.00, 300),
(36, 'Comida Natural para Perro', 'Comida natural y orgánica para perros.', 60.00, 250),
(36, 'Alimento de Pollo para Perros', 'Alimento seco con pollo para perros.', 45.00, 350),
(36, 'Alimento con Pescado para Perros', 'Croquetas con pescado, ideales para pieles sensibles.', 55.00, 300),
(36, 'Comida para Perro Mayor', 'Alimento para perros mayores con menos calorías.', 38.00, 250),
(36, 'Comida para Perro Obeso', 'Alimento para perros con sobrepeso, bajo en calorías.', 40.00, 200),

-- Subcategoría: Alimento para Gatos
(37, 'Croquetas para Gato Adulto', 'Croquetas balanceadas para gatos adultos.', 40.00, 300),
(37, 'Comida Húmeda para Gato', 'Comida húmeda en lata para gatos.', 45.00, 350),
(37, 'Snacks para Gatos', 'Golosinas para gatos.', 18.00, 400),
(37, 'Croquetas para Gatitos', 'Alimento para gatitos con más nutrientes.', 35.00, 250),
(37, 'Comida para Gato Esterilizado', 'Comida para gatos esterilizados.', 38.00, 300),
(37, 'Comida Natural para Gatos', 'Comida natural y orgánica para gatos.', 50.00, 200),
(37, 'Alimento con Pescado para Gatos', 'Alimento con pescado para gatos.', 42.00, 350),
(37, 'Comida para Gato Mayor', 'Alimento para gatos mayores con menos calorías.', 40.00, 250),
(37, 'Comida para Gato con Problemas Urinarios', 'Alimento para gatos con problemas urinarios.', 60.00, 200),
(37, 'Comida para Gato Sensible', 'Alimento para gatos con piel sensible.', 55.00, 150),

-- Subcategoría: Accesorios
(38, 'Collares para Perros', 'Collares ajustables para perros de diferentes tamaños.', 15.00, 300),
(38, 'Correas para Perros', 'Correas resistentes para pasear perros.', 20.00, 250),
(38, 'Juguetes para Perros', 'Juguetes resistentes para perros.', 18.00, 350),
(38, 'Camas para Perros', 'Camas cómodas para perros.', 45.00, 150),
(38, 'Arnés para Perros', 'Arnés de seguridad para perros.', 25.00, 200),
(38, 'Platos para Perros', 'Platos de acero inoxidable para perros.', 10.00, 300),
(38, 'Ropa para Perros', 'Ropa para perros de diferentes tamaños y estilos.', 30.00, 250),
(38, 'Botellas para Perros', 'Botellas de agua portátiles para perros.', 12.00, 400),
(38, 'Cinturones de Seguridad para Perros', 'Cinturones de seguridad para perros en vehículos.', 35.00, 150),
(38, 'Jaulas para Perros', 'Jaulas para perros de diferentes tamaños.', 50.00, 100),

-- Subcategoría: Higiene
(39, 'Shampoo para Perros', 'Shampoo suave para el baño de perros.', 18.00, 350),
(39, 'Toallitas Húmedas para Perros', 'Toallitas húmedas para limpiar a perros.', 12.00, 400),
(39, 'Desinfectante para Perros', 'Desinfectante para mantener la higiene de los perros.', 20.00, 300),
(39, 'Cepillos para Perros', 'Cepillos especiales para el pelo de los perros.', 15.00, 250),
(39, 'Acondicionador para Perros', 'Acondicionador que suaviza el pelo de los perros.', 22.00, 200),
(39, 'Cortaúñas para Perros', 'Herramienta para cortar las uñas de los perros.', 10.00, 350),
(39, 'Pasta de Dientes para Perros', 'Pasta dental especial para perros.', 8.00, 300),
(39, 'Repelente de Pulgas', 'Repelente natural contra pulgas para perros.', 18.00, 250),
(39, 'Talco para Perros', 'Talco de higiene para perros.', 12.00, 300),
(39, 'Polvo Desinfectante para Perros', 'Polvo para desinfectar camas y accesorios de perros.', 14.00, 200),

-- Subcategoría: Snacks
(40, 'Galletas de Mantequilla', 'Deliciosas galletas de mantequilla.', 12.00, 500),
(40, 'Galletas de Chocolate', 'Galletas con chocolate para todos los gustos.', 14.00, 450),
(40, 'Frutos Secos', 'Mezcla de frutos secos para picar.', 20.00, 350),
(40, 'Barritas Energéticas', 'Barritas saludables para recargar energía.', 10.00, 400),
(40, 'Chocolates', 'Chocolates variados para todos los gustos.', 18.00, 300),
(40, 'Chips', 'Chips de papa o maíz en diferentes sabores.', 8.00, 500),
(40, 'Galletas Saladas', 'Galletas saladas ideales como snack.', 6.00, 600),
(40, 'Tortas Individuales', 'Tortas pequeñas individuales para disfrutar en cualquier momento.', 25.00, 150),
(40, 'Chicles', 'Chicles para refrescar el aliento.', 5.00, 500),
(40, 'Caramelos', 'Caramelos surtidos para disfrutar en cualquier momento.', 3.00, 700),

-- Subcategoría: Galletas
(41, 'Galletas Oreo', 'Galletas de chocolate con crema.', 10.00, 400),
(41, 'Galletas María', 'Galletas clásicas.', 8.00, 500),
(41, 'Galletas Club Social', 'Galletas saladas.', 12.00, 350),
(41, 'Galletas Festival', 'Galletas de sabores variados.', 9.00, 400),
(41, 'Galletas Cua Cua', 'Galletas de chocolate rellenas.', 11.00, 300),
(41, 'Galletas Maná', 'Galletas integrales.', 13.00, 250),
(41, 'Galletas Habaneras', 'Galletas con coco.', 10.50, 200),
(41, 'Galletas Saltín', 'Galletas saladas clásicas.', 8.50, 400),
(41, 'Galletas Rosquitas', 'Galletas dulces tradicionales.', 7.50, 450),
(41, 'Galletas Wafer PIL', 'Galletas tipo wafer.', 12.50, 300),

-- Subcategoría: Chocolates
(42, 'Chocolate Sublime', 'Barra de chocolate con leche.', 7.00, 400),
(42, 'Chocolate Nestlé', 'Chocolate clásico para postres.', 6.50, 350),
(42, 'Chocolate Milka', 'Chocolate importado de alta calidad.', 10.00, 300),
(42, 'Chocolate Ferrero Rocher', 'Chocolate con avellanas.', 15.00, 200),
(42, 'Chocolate Kinder Bueno', 'Chocolate relleno con leche.', 12.00, 250),
(42, 'Chocolate Hersheys', 'Chocolate en barra.', 8.00, 400),
(42, 'Chocolate Ritter Sport', 'Chocolate con diversos rellenos.', 12.50, 150),
(42, 'Chocolate Toblerone', 'Chocolate suizo con miel y almendras.', 14.00, 200),
(42, 'Chocolate Pacari', 'Chocolate orgánico de Ecuador.', 18.00, 100),
(42, 'Chocolate PIL', 'Chocolate boliviano tradicional.', 5.50, 500),

-- Subcategoría: Chips
(43, 'Papas Fritas Pringles', 'Papas fritas en tubo.', 15.00, 400),
(43, 'Chips Lays', 'Papas fritas clásicas.', 8.00, 500),
(43, 'Chips Doritos', 'Chips de maíz con sabor a queso.', 10.00, 400),
(43, 'Chips Ruffles', 'Chips con ondulaciones.', 9.50, 300),
(43, 'Chips Kettle', 'Papas fritas estilo artesanal.', 12.00, 200),
(43, 'Chips Salteñas', 'Chips de maíz boliviano.', 6.50, 450),
(43, 'Chips de Plátano', 'Snacks de plátano frito.', 7.00, 350),
(43, 'Chips de Camote', 'Chips hechos con camote.', 8.50, 300),
(43, 'Chips con Chile', 'Chips picantes.', 9.00, 400),
(43, 'Chips Orgánicos', 'Chips sin conservantes.', 10.50, 250),

-- Subcategoría: Frutos Secos
(44, 'Nueces Naturales', 'Nueces sin sal.', 20.00, 200),
(44, 'Almendras Tostadas', 'Almendras con ligero tostado.', 25.00, 180),
(44, 'Pistachos', 'Pistachos sin cáscara.', 30.00, 150),
(44, 'Maní Salado', 'Maní con sal.', 12.00, 300),
(44, 'Maní Dulce', 'Maní caramelizado.', 14.00, 250),
(44, 'Semillas de Girasol', 'Semillas peladas y tostadas.', 10.00, 400),
(44, 'Mix de Frutos Secos', 'Mezcla de nueces, almendras y pasas.', 28.00, 150),
(44, 'Castañas de Pará', 'Castañas amazónicas.', 35.00, 100),
(44, 'Coco Rallado', 'Coco seco rallado.', 8.00, 300),
(44, 'Pasas', 'Pasas naturales.', 7.50, 350),

-- Subcategoría: Barritas
(45, 'Barritas Nature Valley', 'Barritas de granola.', 12.00, 300),
(45, 'Barritas Kelloggs', 'Barritas con arroz inflado.', 10.50, 350),
(45, 'Barritas Fitness', 'Barritas bajas en calorías.', 11.00, 250),
(45, 'Barritas de Frutas', 'Barritas hechas con pulpa de frutas.', 13.00, 200),
(45, 'Barritas Energéticas', 'Barritas para deportistas.', 15.00, 180),
(45, 'Barritas Chocochip', 'Barritas con chispas de chocolate.', 12.50, 250),
(45, 'Barritas con Miel', 'Barritas endulzadas con miel natural.', 14.00, 220),
(45, 'Barritas Orgánicas', 'Barritas sin conservantes.', 16.00, 150),
(45, 'Barritas Proteicas', 'Barritas altas en proteínas.', 18.00, 100),
(45, 'Barritas de Avena', 'Barritas saludables de avena.', 11.50, 300),

-- Subcategoría: Panes
(46, 'Pan Baguette', 'Pan francés crujiente.', 8.00, 300),
(46, 'Pan Integral', 'Pan saludable integral.', 10.00, 350),
(46, 'Pan Ciabatta', 'Pan italiano artesanal.', 12.00, 200),
(46, 'Pan de Molde', 'Pan blanco de molde.', 9.00, 400),
(46, 'Pan Andino', 'Pan tradicional boliviano.', 6.50, 450),
(46, 'Pan de Centeno', 'Pan oscuro de centeno.', 11.00, 250),
(46, 'Pan de Queso', 'Pan con trozos de queso.', 7.50, 300),
(46, 'Pan Dulce', 'Pan con azúcar y canela.', 8.50, 350),
(46, 'Pan de Semillas', 'Pan con mezcla de semillas.', 12.50, 200),
(46, 'Pan de Papa', 'Pan elaborado con papa.', 7.00, 400),

-- Subcategoría: Tortas
(47, 'Torta de Chocolate', 'Torta esponjosa de chocolate.', 50.00, 100),
(47, 'Torta Tres Leches', 'Torta húmeda de tres leches.', 55.00, 80),
(47, 'Torta de Zanahoria', 'Torta casera de zanahoria.', 45.00, 120),
(47, 'Torta Selva Negra', 'Torta de chocolate y crema.', 60.00, 70),
(47, 'Torta de Vainilla', 'Torta clásica de vainilla.', 40.00, 150),
(47, 'Torta de Frutas', 'Torta decorada con frutas.', 65.00, 50),
(47, 'Torta Marmoleada', 'Torta con diseño de mármol.', 48.00, 90),
(47, 'Torta Red Velvet', 'Torta de terciopelo rojo.', 70.00, 60),
(47, 'Torta de Limón', 'Torta con toque cítrico.', 50.00, 100),
(47, 'Torta de Fresa', 'Torta con relleno de fresas.', 55.00, 80),

-- Subcategoría: Galletas de Panadería
(48, 'Galletas de Chocolate', 'Galletas horneadas con chispas de chocolate.', 15.00, 300),
(48, 'Galletas de Avena', 'Galletas integrales hechas con avena.', 12.00, 400),
(48, 'Galletas de Mantequilla', 'Clásicas galletas crujientes de mantequilla.', 14.00, 350),
(48, 'Galletas Decoradas', 'Galletas con diseños temáticos.', 18.00, 250),
(48, 'Galletas de Jengibre', 'Galletas especiadas tradicionales.', 16.00, 200),
(48, 'Galletas con Frutas Secas', 'Galletas con trozos de frutos secos.', 17.00, 150),
(48, 'Galletas de Coco', 'Galletas horneadas con coco rallado.', 13.00, 300),
(48, 'Galletas Sin Gluten', 'Galletas aptas para celíacos.', 20.00, 100),
(48, 'Galletas de Limón', 'Galletas con un toque cítrico.', 14.50, 350),
(48, 'Galletas Artesanales', 'Galletas caseras de receta tradicional.', 18.00, 200),

-- Subcategoría: Masas y Bollería
(49, 'Croissant', 'Bollería francesa tradicional.', 10.00, 300),
(49, 'Empanadas de Pollo', 'Empanadas horneadas rellenas de pollo.', 12.00, 250),
(49, 'Rollos de Canela', 'Pan dulce con canela y glaseado.', 15.00, 200),
(49, 'Medialunas', 'Bollería dulce similar al croissant.', 9.00, 400),
(49, 'Pan de Leche', 'Pan suave y ligeramente dulce.', 8.00, 500),
(49, 'Pasteles de Queso', 'Pasteles salados rellenos de queso.', 11.00, 300),
(49, 'Ensaïmada', 'Bollería española espolvoreada con azúcar glas.', 14.00, 150),
(49, 'Empanadas de Carne', 'Empanadas tradicionales de carne.', 13.00, 350),
(49, 'Churros', 'Bollería frita con azúcar.', 10.00, 400),
(49, 'Strudel de Manzana', 'Masa rellena con manzanas.', 18.00, 100),

-- Subcategoría: Postres
(50, 'Flan de Caramelo', 'Postre cremoso con caramelo.', 10.00, 400),
(50, 'Mousse de Chocolate', 'Postre ligero y espumoso.', 15.00, 300),
(50, 'Tiramisú', 'Postre italiano con café y mascarpone.', 20.00, 200),
(50, 'Gelatina de Frutas', 'Postre refrescante con trozos de frutas.', 8.00, 500),
(50, 'Budín de Pan', 'Postre tradicional hecho con pan.', 12.00, 300),
(50, 'Crema Volteada', 'Postre similar al flan con textura más densa.', 14.00, 250),
(50, 'Pie de Limón', 'Postre con base de galleta y crema de limón.', 18.00, 150),
(50, 'Cheesecake', 'Postre cremoso a base de queso.', 22.00, 100),
(50, 'Panna Cotta', 'Postre italiano a base de crema.', 16.00, 200),
(50, 'Brownies', 'Postre de chocolate compacto.', 10.00, 400);
GO

drop table producto


-- Insertar usuario para el carrito
INSERT INTO cliente (nombre, correo, pass)
VALUES ('Juan López', 'juan.lopez@gmail.com', 'juan123');
GO
-- Crear un carrito para el usuario
INSERT INTO carrito (cliente_id)
VALUES (1);
GO
-- Agregar un producto al carrito
INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio_unidad)
VALUES (1, 1,2,7.50); -- Aquí se agrega 2 unidades del producto con producto_id = 1
GO

use meetal
select * from producto

select * 
from producto p
join 
subcategoria s on p.subcategoria_id=s.subcategoria_id
where s.subcategoria_id=7

select * from subcategoria
where subcategoria.categoria_id=1

select * from categoria
