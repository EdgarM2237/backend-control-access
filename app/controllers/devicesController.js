import connection from "../config/db.js";

function workerCode() {
    const year = new Date().getFullYear().toString();
    const minute = new Date().getMinutes().toString().padStart(2, "0");
    const hour = new Date().getHours().toString().padStart(2, "0");
    const day = new Date().getDay().toString().padStart(2, "0");
    const code = year + hour + day + minute;
    return code;
}

const manageDevices = {
    devices: (req, res) => {
        const query = 'SELECT devices.device_id, devices.device_name, devices.device_dep, devices.device_uid, devices.device_serial, devices.device_date, devices.device_mode, estado_device.estado_name FROM devices JOIN estado_device ON devices.device_mode = estado_device.estado_id';
        connection.query(query, (err, results) => {
            if (err) {
                console.error("Error fetching user logs:", err);
                res.status(500).json({ error: "Internal server error" });
                return;
            }
            res.status(200).json(results);
            return;
        })
    },
    addDevices: (req,res) => {
        const {device_name, device_uid} = req.body
        const date = new Date();
        const device_date =
                    date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
        const serialnumber = workerCode();
        const query = 'INSERT INTO devices (device_name, device_dep, device_uid, device_date, device_serial) VALUES (?, ?, ?, ?, ?)';
        connection.query(query, [device_name, device_name, device_uid, device_date, serialnumber], (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).json({ error: err, message: "Error al registrar el dispositivo" });
            } else {
                return res.status(200).json({ message: "Dispositivo registrado exitosamente!" });
            }
        })
    },
    editDevices: (req,res) => {
        const {device_name, device_mode, device_id, device_uid} = req.body
        console.log(device_name, device_mode, device_id, device_uid);
        const query = 'UPDATE devices SET device_name = ?, device_uid = ?, device_mode = ? WHERE device_id = ?';
        connection.query(query, [device_name, device_uid ,device_mode, device_id], (err, results) => {
            if (err) {
                return res.status(500).json({ error: err, message: "Error al editar el dispositivo" });
            }
            if (results.affectedRows < 1) {
                return res.status(404).json({ message: "Dispositivo no encontrado" });
            }
            return res.status(200).json({ message: "Dispositivo editado exitosamente" });
        })
    },
    deleteDevices: (req,res) => {
        const {device_id} = req.body
        const query = 'DELETE FROM devices WHERE device_id = (?)';
        connection.query(query, [device_id], (err, results) => {
            if (err) {
                return res.status(500).json({ error: err, message: "Error al eliminar el dispositivo" });
            }
            if (results.affectedRows < 1) {
                return res.status(404).json({ message: "Dispositivo no encontrado" });
            }
            return res.status(200).json({ message: "Dispositivo eliminado exitosamente" });
        })

    },
    deviceMode: (req,res) => {
        const query = 'SELECT * FROM estado_device';
        connection.query(query, (err, results) => {
            if(err){
                return res.status(500).json({ error: err, message: "Error al obtener los modos de los dispositivos" });
            } else {
                return res.status(200).json(results);
            }
        })
    }
}

export default manageDevices;
