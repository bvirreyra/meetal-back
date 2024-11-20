CREATE PROCEDURE meetal
AS
	SELECT cl.nombre, (cl.correo) AS correo,(c.fecha_creacion) AS fecha_creación, (p.nombre) AS producto, (p.descripcion) AS descripcion, (dc.precio_unidad) AS precio_unidad, (dc.cantidad) AS cantidad, (dc.precio_unidad*dc.cantidad) AS subtotal 
	FROM detalle_carrito dc
		join carrito c ON dc.carrito_id=c.carrito_id
		join cliente cl ON cl.cliente_id=c.cliente_id
		join producto p ON p.producto_id=dc.producto_id
	WHERE c.cliente_id=1

EXEC meetal