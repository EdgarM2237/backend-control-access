import express from 'express';
import authRoutes from './routes/authRoutes.js';
import usersRoutes from './routes/usersRoutes.js';
import dotenv from 'dotenv';
import morgan from 'morgan';
import { user_logs } from './models/User_logs.js';
import cors from 'cors';
import manageUsers from './controllers/usersController.js';
import cookieParser from 'cookie-parser';
import { authenticateTokenFromCookie } from './middleware/manageMiddleware.js';
import { devices } from './models/Devices.js';


dotenv.config();
morgan.token('body', (req) => JSON.stringify(req.body));
const app = express();

app.use(cookieParser());
app.use(express.json());
app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true,
}));
app.use(morgan(':method :url :status :res[content-length] - :response-time ms :body'));
app.use('/api/auth', authRoutes); // Autenticación
app.use('/api/users', usersRoutes); // Usuarios

app.get('/api/user_logs', user_logs); // users logs
app.get('/api/usuario', devices); // devices


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
1
