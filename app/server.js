import express from "express";
import authRoutes from "./routes/authRoutes.js";
import usersRoutes from "./routes/usersRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import rolesRoutes from "./routes/rolesRoutes.js";
import devicesRoute from "./routes/devicesRoutes.js";
import dotenv from "dotenv";
import morgan from "morgan";
import { user_logs } from "./models/User_logs.js";
import cors from "cors";
import cookieParser from "cookie-parser";
import path from "path";
import {
  uploadProfilePic,
  updateProfilePic,
  deleteProfilePic,
} from "./controllers/imageController.js";
import { fileURLToPath } from "url";
import { upload } from "./models/multer.js";
import { resendCode, verifyCode } from "./controllers/verificationController.js";
import { updateAdminProfilePic, uploadAdminProfilePic } from "./controllers/adminImageController.js";
import { autenticationDoor } from "./controllers/autenticationController.js";

dotenv.config();
morgan.token("body", (req) => JSON.stringify(req.body));

const verificationCodes = new Map();
const app = express();

// Estas dos líneas reemplazan el uso de __dirname en módulos ES
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
console.log(__dirname);

// Middlewares
app.use(cookieParser());
app.use(express.json());
app.use(
  cors({
    origin: "http://localhost:5173",
    credentials: true,
  })
);
app.use(
  morgan(":method :url :status :res[content-length] - :response-time ms :body")
);

//----------Rutas de gestion--------//
app.use("/api/auth", authRoutes); // Autenticación
app.use("/api/users", usersRoutes); // Usuarios
app.use("/api/admin", adminRoutes); //admins
app.use("/api/roles", rolesRoutes); //roles
app.use("/api/devices", devicesRoute); //Dispositivos
app.get("/api/user_logs", user_logs); // users logs
app.get("/api/autentication", autenticationDoor);


//---------Rutas de Servicios----------//
// Servir archivos estáticos desde la carpeta 'uploads'
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// Rutas para subir, actualizar y eliminar fotos de perfil USUARIOS
app.post("/upload/:id", upload.single("profilePic"), uploadProfilePic);
app.put("/upload/:id", upload.single("profilePic"), updateProfilePic);
app.delete("/upload/:id", deleteProfilePic);

// Rutas para subir y actualizar fotos de perfil ADMINISTRADORES
app.post("/upload/admin/:id", upload.single("profilePic"), uploadAdminProfilePic);
app.put("/upload/admin/:id", upload.single("profilePic"), updateAdminProfilePic);


// Ruta para verificar el código de verificación
app.post("/api/auth/resend-code", resendCode);
app.post("/api/auth/verify-code", verifyCode);

// Mostrar el puerto utilizado
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
1;
