--- PROCEDIMIENTO PARA VER EL CARRITO DEL CLIENTE
CREATE PROCEDURE carrito_cliente
AS
	SELECT cl.nombre, (cl.correo) AS correo,(c.fecha_creacion) AS fecha_creaci�n, (p.nombre) AS producto, (p.descripcion) AS descripcion, (dc.precio_unidad) AS precio_unidad, (dc.cantidad) AS cantidad, (dc.precio_unidad*dc.cantidad) AS subtotal 
	FROM detalle_carrito dc
		join carrito c ON dc.carrito_id=c.carrito_id
		join cliente cl ON cl.cliente_id=c.cliente_id
		join producto p ON p.producto_id=dc.producto_id
	WHERE c.cliente_id=1

EXEC carrito_cliente

--PROCEDIMIENTO PARA LISTAR CATEGORIAS
CREATE PROCEDURE listar_categorias
AS
SELECT categoria_id, nombre, descripcion 
FROM categoria;

EXEC listar_categorias

CREATE PROCEDURE listar_subcategorias
    @categoria_id INT
AS
BEGIN
    SELECT subcategoria_id, categoria_id, nombre, descripcion
    FROM subcategoria
    WHERE categoria_id = @categoria_id;
END;


EXEC listar_subcategorias
	@categoria_id=2

CREATE PROCEDURE listar_productos
	@subcategoria_id INT
AS
BEGIN
	SELECT producto_id,subcategoria_id,nombre,descripcion,precio,stock
	FROM producto
	WHERE subcategoria_id=@subcategoria_id;
END;

EXEC listar_productos
	@subcategoria_id=6

--- PROCEDIMIENTO PARA PAGAR EL CARRITO 
CREATE PROCEDURE pagar_carrito
	@cliente_id INT,
	@carrito_id INT,
    @producto_id INT,
    @cantidad INT,
    @precio_unidad DECIMAL(10, 2)
AS
BEGIN
	BEGIN TRANSACTION;
		BEGIN TRY
		INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio_unidad)
		VALUES (@carrito_id, @producto_id, @cantidad, @precio_unidad);
		INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio_unidad)
		VALUES (@carrito_id, @producto_id, @cantidad, @precio_unidad);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		PRINT ERROR_MESSAGE();
	END CATCH;
END;



--- PROCEDIMIENTO PARA EL ESTADO DEL CARRITO DEL CLIENTE
CREATE PROCEDURE estado_carrito
AS
SELECT cl.nombre, cl.correo, c.fecha_creacion, ic.nombre_estado
FROM cliente cl
	join carrito c ON cl.cliente_id=c.cliente_id
	join identificador_carrito ic ON c.estado=ic.estado_id
WHERE cl.cliente_id=1

EXEC estado_carrito

CREATE PROCEDURE inserta_carrito
    @carrito_id INT,
    @producto_id INT,
    @cantidad INT,
    @precio_unidad DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad, precio_unidad)
    VALUES (@carrito_id, @producto_id, @cantidad, @precio_unidad);
END;

EXEC inserta_carrito
    @carrito_id = 1,
    @producto_id = 3,
    @cantidad = 3,
    @precio_unidad = 12.00;

select * from detalle_carrito							