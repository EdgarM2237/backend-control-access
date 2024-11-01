import express from 'express';
import manageDevices from '../controllers/devicesController.js';

const router = express.Router();

router.get('/', manageDevices.devices);
router.patch('/editdevice', manageDevices.editDevices);
router.delete('/deletedevice', manageDevices.deleteDevices);
router.post('/adddevice', manageDevices.addDevices);
router.get('/devicemode', manageDevices.deviceMode);

export default router;
