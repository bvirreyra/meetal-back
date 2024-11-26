import * as da from "../conection/conn.js";

export const crudCarrito = async (req, res) => {
  console.log("crudCarrito", req.query);

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

  let message = "Operación realizada satisfactoriamente!";
  let query = "";

  try {
    if (opcion == "R") {
      query = `
                SELECT * FROM cliente;
              `;
      message = "Clientes listados satisfactoriamente!";
    }
    if (opcion == "H") {
      query = `
            EXEC carrito_cliente;
          `;
      message = "Clientes listados satisfactoriamente!";
    }
    const respuesta = await da.obtenerDatos(query);
    res.status(200).json({ message, data: respuesta });
  } catch (error) {
    console.error("Error en crudProducto:", error);
    res
      .status(500)
      .json({ message: "Error en la consulta: " + error.message, data: [] });
  }
};
