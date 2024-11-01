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
      "SELECT id, username, serialnumber, gender, email, card_uid, user_date FROM users ORDER BY user_date DESC";
    connection.query(query, (err, results) => {
      if (err) {
        console.error("Error fetching user logs:", err);
        res.status(500).json({ error: "Internal server error" });
        return;
      }
      res.json(results);
    });
  },

  userEditPost: (req, res) => {
    const { username, email, gender, card_uid, id } = req.body;
    console.log(username, email, gender, card_uid, id);

    connection.query(
      "UPDATE users SET username = ?, email = ?, gender = ?, card_uid = ? WHERE id = ?",
      [username, email, gender, card_uid, id],
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
        return res
          .status(200)
          .json({ message: "Usuario editado exitosamente!", result });
      }
    );
  },

  deleteUser: (req, res) => {
    const { id } = req.body;
    connection.query(
      "DELETE FROM users WHERE id = (?)",
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
          console.log(result);
          return res
            .status(200)
            .json({ message: "Usuario eliminado exitosamente!", result });
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
