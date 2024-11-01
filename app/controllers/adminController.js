import connection from "../config/db.js";
import bcrypt from "bcryptjs";

const manageAdmin = {
    //Llamar a los administradores
  admin: (req, res) => {
    const query = `SELECT admin.admin_id, admin.admin_name, admin.admin_email, admin.admin_date, admin.admin_img, roles.nombre_rol FROM admin JOIN roles ON admin.rol_id = roles.rol_id WHERE admin.is_active = 1`;
    connection.query(query, (err, results) => {
      if (err) {
        console.error("Error fetching user logs:", err);
        res.status(500).json({ error: "Internal server error" });
        return;
      }
      res.status(200).json(results);
      return;
    });
  },
  //editar un administrador
  editAdmin: (req, res) => {
    const { admin_name: username, admin_email: email, admin_id: id, rol_id: rol } = req.body;
    const query =
      "UPDATE admin SET admin_name = ?, admin_email = ?, rol_id = ? WHERE admin_id = ?";
    connection.query(query, [username, email, rol, id], (err, result) => {
        if (err) {
            console.log(err);
            return res
                .status(500)
                .json({ error: err, message: "Error al seleccionar al usuario" });
        }
        if(result.affectedRows < 1){
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        console.log(result)
        res.status(200).json({message: "El usuario se ha editado exitosamente"})
        return;
    });
  },
  //eliminar un administrador
  deleteAdmin: (req, res) => {
    const { admin_id: id } = req.body;
    const query = "UPDATE admin SET is_active = 0 WHERE admin_id = (?)";
    connection.query(query, [id], (err, result) => {
        if(err){
            console.log(err)
            return res
                .status(500)
                .json({ error: err, message: "Error al eliminar el usuario" });
        }
        if(result.affectedRows < 1){
            return res.status(404).json({ message: "Usuario no encontrado" });
        }
        res.status(200).json({message: "El usuario se ha eliminado exitosamente"})
        return;
    })
  },
  //agregar un administrador
  addAdmin: (req, res) => {
    const data = req.body;
    const { rol_id: rol, admin_pwd: password, admin_name: username, admin_email: email } = data;
    const date = new Date();
    const admin_date =
      date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) return res.status(500).json({ error: err });
        const newUser = { username, email, password: hashedPassword };
        const queryAddAdmin = "INSERT INTO admin (admin_name, admin_email, admin_pwd, admin_date, rol_id) VALUES (?, ?, ?, ?, ?)";
        connection.query(queryAddAdmin, [newUser.username, newUser.email,newUser.password, admin_date, rol], (err, result) => {
            if(err){
                console.log(err)
                return res.status(500).json({ error: err, message: "Error al registrar el usuario" });
            }
            res.status(200).json({message: "El usuario se ha registrado exitosamente"})
            return;
        })
    })
  },
  getNameAdmin: (req, res) => {
    const query = "SELECT admin_name, admin_img FROM admin WHERE admin_email = (?)";
    const { email } = req.body;
    connection.query(query, [email], (err, result) => {
        if(err){
            return res.status(500).json({error: err, message: "Error al obtener el nombre del administrador"})
        }
        if(result.length < 1){
            return res.status(404).json({message: "Administrador no encontrado"})
        }
        res.status(200).json(result[0])
        return;
    })

  }
};

export default manageAdmin;
