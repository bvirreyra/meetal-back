import * as da from "../conection/conn.js";

export const crudCliente = async (req, res) => {
  console.log("crudCliente:      ", req.query);

  const {
    opcion,
    cliente_id,
    nombre,
    correo,
    pass,
    categoria_id,
    subcategoria_id,
  } = req.query;

  let message = "Operación realizada satisfactoriamente!";
  let query = "";

  try {
    // if (opcion == "C") {
    //   query = `
    //           INSERT INTO cliente (nombre, correo, pass)
    //           VALUES ('${nombre}', '${correo}', '${pass}');
    //         `;
    //   message = "Cliente creado satisfactoriamente!";
    // }
    // if (opcion == "U") {
    //   query = `
    //           UPDATE cliente
    //           SET
    //             nombre = '${nombre}',
    //             correo = '${correo}'
    //           WHERE cliente_id = ${cliente_id};
    //         `;
    //   message = "Cliente actualizado satisfactoriamente!";
    // }
    // if (opcion == "D") {
    //   query = `
    //           DELETE FROM cliente
    //           WHERE cliente_id = ${id};
    //         `;
    //   message = "Cliente eliminado satisfactoriamente!";
    // }
    if (opcion == "C") {
      query = `
              EXEC listar_categorias;
            `;
      message = "Categorías listadas satisfactoriamente!";
    }
    if (opcion == "S") {
      query = `
              EXEC listar_subcategorias
                @categoria_id = ${categoria_id};
            `;
      message = "Subcategorías listadas satisfactoriamente!";
    }
    if (opcion == "P") {
      query = `
              EXEC listar_productos
	              @subcategoria_id=${subcategoria_id};
            `;
      message = "Productos listadas satisfactoriamente!";
    }
    if (opcion == "R") {
      query = `
              SELECT cliente_id, nombre, correo FROM cliente;
            `;
      message = "Clientes listados satisfactoriamente!";
    }
    if (opcion == "H") {
      query = `
          EXEC carrito_cliente;
        `;
      message = "Clientes listados satisfactoriamente!";
    }
    if (opcion == "J") {
      query = `
          EXEC estado_carrito;
        `;
      message = "Clientes listados satisfactoriamente!";
    }
    const respuesta = await da.obtenerDatos(query);
    res.status(200).json({ message, data: respuesta });
  } catch (error) {
    console.error("Error en crudCliente:", error);
    res
      .status(500)
      .json({ message: "Error en la consulta: " + error.message, data: [] });
  }
};
