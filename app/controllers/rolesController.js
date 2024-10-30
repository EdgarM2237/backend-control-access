import connection from "../config/db.js";

const manageRoles = {
    roles: (req, res) => {
        const query = 'SELECT * FROM roles WHERE is_active = 1';
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
    addRoles: (req, res) => {
        const { nombre_rol, description_rol } = req.body;
        const query = 'INSERT INTO roles (nombre_rol, description_rol, date) VALUES (?, ?, ?)';
        const date = new Date();
        const dateRole = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
        connection.query(query, [nombre_rol, description_rol, dateRole], (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).json({ error: err, message: "Error al registrar el rol" });
            } else {
                return res.status(200).json({ message: "Rol registrado exitosamente!" });
            }
        })
    },
    editRoles: (req, res) => {
        const { nombre_rol, description_rol, rol_id } = req.body;
        const query = 'UPDATE roles SET nombre_rol = ?, description_rol = ? WHERE rol_id = ?';
        connection.query(query, [nombre_rol, description_rol, rol_id], (err, results) => {
            if(err){
                return res.status(500).json({error: err, message: "Error al editar el rol"})
            }
            if(results.affectsRows < 1){
                return res.status(404).json({message: "Rol no encontrado"})
            }
            return res.status(200).json({message: "Rol editado exitosamente"})
        })
    },
    deleteRoles: (req, res) => {
        const { rol_id } = req.body;
        const query = 'UPDATE roles SET is_active = 0 WHERE rol_id = (?)';
        connection.query(query, [rol_id], (err, results) => {
            if (err) {
                return res.status(500).json({ error: err, message: "Error al eliminar el rol" });
            } else {
                if (results.affectedRows < 1) {
                    return res.status(404).json({ message: "Rol no encontrado" });
                }
                return res.status(200).json({ message: "Rol eliminado exitosamente" });
            }
        })
    }
}

export default manageRoles;
