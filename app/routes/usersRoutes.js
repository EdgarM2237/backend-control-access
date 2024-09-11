import express from 'express';
import manageUsers from '../controllers/usersController.js';
import { authenticateTokenFromCookie } from '../middleware/manageMiddleware.js';

const router = express.Router();

router.get('/', manageUsers.Users);
router.patch('/editusers', manageUsers.userEditPost);
router.post('/deleteusers', manageUsers.deleteUser);
router.post('/addusers', manageUsers.addUser);

export default router;
