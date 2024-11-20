import { Router } from "express";
import * as m from '../controllers/metodosProductos.js'
import * as v from '../controllers/metodosVenta.js'
import * as c from '../controllers/metodosClientes.js'

const router = Router();


/******* PRODUCTOS */
router.get('/api/listarProductos',m.listarProductos);
router.get('/api/crudCarrito',v.crudCarrito);
router.get('/api/crudCliente/',c.crudCliente);


export default router;
