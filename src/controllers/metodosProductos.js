import * as da from '../conection/conn.js';

export const listarProductos= async (req,res) =>{
  console.log('listarProductos',req.query);
  try {
    const respuesta = await da.obtenerDatos('select * from producto');
    res.status(200).json({message: 'Consulta exitosa!!!', data: respuesta});
  } catch (error) {
    console.log('Error listarProductos',error);
    res.status(500).json({message: 'Error consulta: , ' + error, data: []});
  }
}

export const crudProducto = async (req, res) => {
  console.log('crudProducto', req.query);
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
          INSERT INTO producto (subcategoria_id, nombre, descripcion, precio, stock)
          VALUES (${subcategoria_id}, '${nombre}', '${descripcion}', ${precio}, ${stock});
        `;
        message = 'Producto creado satisfactoriamente!';
        break;
      case 'U':
        query = `
          UPDATE producto
          SET 
            subcategoria_id = ${subcategoria_id},
            nombre = '${nombre}',
            descripcion = '${descripcion}',
            precio = ${precio},
            stock = ${stock}
          WHERE producto_id = ${id};
        `;
        message = 'Producto actualizado satisfactoriamente!';
        break;
      case 'D':
        query = `
          DELETE FROM producto
          WHERE producto_id = ${id};
        `;
        message = 'Producto eliminado satisfactoriamente!';
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
