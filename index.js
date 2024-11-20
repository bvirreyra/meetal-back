import express from "express";
import cors from 'cors';
import sr from './src/routes/rutas.js';

//ROUTES
import { config as dotenvConfig } from 'dotenv';

dotenvConfig();
const app = express();

//MIDDLEWARE
app.use(cors());
app.use(express.json());

//ROUTES
app.use(sr);

//SERVIDOR WEB
app.listen(process.env.PORT,()=> console.log(`Corriendo en el puerto ${process.env.PORT}`))