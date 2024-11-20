import * as da from '../conection/conn.js';

export const crudCarrito = async (req, res) => {
    console.log('crudCarrito', req.query);
  
    const {
      opcion,
      id,
      subcategoria_id,
      nombre,
      descripcion,
      precio,
      stock,
      carrito_id,
      producto_id,
      cantidad,
    } = req.query;
  
    let message = 'Operación realizada satisfactoriamente!';
    let query = '';
  
    try {
      switch (opcion) {
        case 'I':
        query = `
          INSERT INTO detalle_carrito (carrito_id, producto_id, cantidad)
          VALUES (${carrito_id}, ${producto_id}, ${cantidad});
        `;
        message = 'Producto agregado al carrito satisfactoriamente!';
        break;

      case 'D':
        query = `
          DELETE FROM detalle_carrito
          WHERE carrito_id = ${carrito_id} AND producto_id = ${producto_id};
        `;
        message = 'Producto eliminado del carrito satisfactoriamente!';
        break;

      case 'U':
        query = `
          UPDATE detalle_carrito
          SET cantidad = ${cantidad}
          WHERE carrito_id = ${carrito_id} AND producto_id = ${producto_id};
        `;
        message = 'Cantidad del producto actualizada en el carrito!';
        break;

      case 'listarProductos':
        query = `
          SELECT * FROM producto;
        `;
        message = 'Productos listados satisfactoriamente!';
        break;

      case 'R':
        query = `
          SELECT 
            c.carrito_id, 
            u.nombre AS usuario, 
            p.nombre AS producto, 
            dc.cantidad, 
            dc.precio_total 
          FROM detalle_carrito dc
          INNER JOIN carrito c ON dc.carrito_id = c.carrito_id
          INNER JOIN usuario u ON c.usuario_id = u.usuario_id
          INNER JOIN producto p ON dc.producto_id = p.producto_id
          WHERE c.carrito_id = ${carrito_id};
        `;
        message = 'Productos en el carrito listados satisfactoriamente!';
        break;
        default:
          throw new Error('Opción no válida.');
      }
      const respuesta = await da.obtenerDatos(query);
      res.status(200).json({ message, data: respuesta });
    } catch (error) {
      console.error('Error en crudProducto:', error);
      res.status(500).json({ message: 'Error en la consulta: ' + error.message, data: [] });
    }
  };