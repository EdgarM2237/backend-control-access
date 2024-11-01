import connection from "../config/db.js";

function workerCode() {
  const year = new Date().getFullYear().toString();
  const minute = new Date().getMinutes().toString().padStart(2, "0");
  const hour = new Date().getHours().toString().padStart(2, "0");
  const day = new Date().getDay().toString().padStart(2, "0");
  const code = year + hour + day + minute;
  return code;
}

const manageUsers = {
  Users: (req, res) => {
    const query =
      "SELECT user_id, genere, user_name, user_serial, user_email, card_uid, user_date, is_active, user_img, GROUP_CONCAT(CONCAT(device_id, ':', device_dep) SEPARATOR ',')  AS devices FROM permisos JOIN users ON permisos.users_id = users.user_id JOIN devices ON permisos.devices_id = devices.device_id WHERE is_active = 1 GROUP BY users.user_id";
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

  userEditPost: (req, res) => {
    try {
      const {
        user_name: username,
        user_email: email,
        card_uid,
        user_id: id,
        devices,
      } = req.body;
      const devicesValue = devices.map((device) => [id, device]);
      const queryUser =
        "UPDATE users SET user_name = ?, user_email = ?, card_uid = ? WHERE user_id = ?";
      const queryPermisosDelete = "DELETE FROM permisos WHERE users_id = ?";
      const queryPermisosInsert =
        "INSERT INTO permisos (users_id, devices_id) VALUES ?";
      connection.query(
        queryUser,
        [username, email, card_uid, id],
        (err, result) => {
          if (err) {
            console.log(err);
            return res
              .status(500)
              .json({ error: err, message: "Error al seleccionar al usuario" });
          }
          if (result.affectedRows < 1) {
            return res.status(404).json({ message: "Usuario no encontrado" });
          }
        }
      );
      connection.query(queryPermisosDelete, [id], (err, result) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: err, message: "Error al eliminar los permisos" });
        }
      });

      connection.query(queryPermisosInsert, [devicesValue], (err, result) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: err, message: "Error al insertar los permisos" });
        }
        return res
          .status(200)
          .json({ message: "El usuario se ha editado exitosamente" });
      });
    } catch (err) {
      console.log(err);
    }
  },
  deleteUser: (req, res) => {
    const { id } = req.body;
    console.log(req.body);
    connection.query(
      "UPDATE users SET is_active = 0, user_serial = NULL WHERE user_id = (?)",
      [id],
      (err, result) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: err, message: "Error al eliminar el usuario" });
        } else {
          if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Usuario no encontrado" });
          }
          connection.query(
            "DELETE FROM users WHERE users_id = (?)",
            [id],
            (err, result) => {
              if(err) console.log(err)
              if(result.affectedRows === 0){
                return res.status(404).json({message: "Usuario no encontrado"})
              }else{
                return res.status(200).json({message: "Usuario eliminado exitosamente", result })
              }

            })
        }
      }
    );
  },
  addUser: (req, res) => {
    const data = req.body;
    const serialnumber = workerCode();
    const { username, gender, email, card_uid } = data;
    console.log(username, serialnumber, gender, email, card_uid);
    const date = new Date();
    const user_date =
      date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
    const query =
      "INSERT INTO users (username, serialnumber, gender, email, card_uid, user_date) VALUES (?, ?, ?, ?, ?, ?)";
    connection.query(
      query,
      [username, serialnumber, gender, email, card_uid, user_date],
      (err, result) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: err, message: "Error al registrar el usuario" });
        } else {
          return res
            .status(200)
            .json({ message: "Usuario registrado exitosamente!" });
        }
      }
    );
  },
};

export default manageUsers;
