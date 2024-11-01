import express from 'express';
import manageAdmin from '../controllers/adminController.js';

const router = express.Router();

router.get('/', manageAdmin.admin);
router.patch('/editadmin', manageAdmin.editAdmin);
router.delete('/deleteadmin', manageAdmin.deleteAdmin);
router.post('/addadmin', manageAdmin.addAdmin);
router.post('/getadminname', manageAdmin.getNameAdmin);


export default router;
