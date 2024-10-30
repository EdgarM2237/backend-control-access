import express from 'express';
import manageRoles from '../controllers/rolesController.js';

const router = express.Router();

router.get('/', manageRoles.roles);
router.patch('/editroles', manageRoles.editRoles);
router.delete('/deleteroles', manageRoles.deleteRoles);
router.post('/addroles', manageRoles.addRoles);

export default router;
