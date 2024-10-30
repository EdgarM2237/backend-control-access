import connection from "../config/db.js";

export const autenticationDoor = (req, res) => {
  const { device_token, card_uid } = req.query;
  try {
    connection.query(
      "SELECT * FROM devices WHERE device_uid = (?)",
      [device_token],
      (err, results) => {
        if (err) {
          return res.status(500).json({
            error: err,
            message: "Error al autenticar el dispositivo",
          });
        }
        if (results.length < 1) {
          return res.status(404).json({ message: "Dispositivo no encontrado" });
        }
        const { device_mode, device_dep, device_id } = results[0];
        // Modes: 1 = registro, 2 = revision, 3 = produccion
        if (device_mode === 1) {
          connection.query(
            "SELECT * FROM users WHERE card_uid = (?)",
            [card_uid],
            (err, results) => {
              if (err) {
                return res.status(500).json({
                  error: err,
                  message: "Error al autenticar el usuario",
                });
              }
              console.log(results);
              if (results.length < 1) {
                const date = new Date();
                const user_date =
                  date.getFullYear() +
                  "-" +
                  (date.getMonth() + 1) +
                  "-" +
                  date.getDate();
                connection.query(
                  "INSERT INTO users (card_uid, user_date) VALUES (?, ?)",
                  [card_uid, user_date],
                  (err, results) => {
                    if (err) {
                      return res.status(500).json({
                        error: err,
                        message: "Error al registrar el usuario",
                      });
                    }
                    connection.query(
                      "INSERT INTO permisos (users_id, devices_id) VALUES (?, ?)",
                      [results.insertId, device_id],
                      (err, results) => {
                        if (err) return res.status(500).json({ error: err });
                        return res.status(201).json({
                          message: "Usuario registrado exitosamente!",
                        });
                      }
                    );
                  }
                );
              } else {
                return res
                  .status(202)
                  .json({ message: "Usuario ya registrado!" });
              }
            }
          );
        } else if (device_mode === 2) {
          return res.status(500).json({ message: "Dispositivo inactivo" });
        } else if (device_mode === 3) {
          try {
            connection.query(
              "SELECT * FROM users WHERE card_uid = ?",
              [card_uid],
              (err, results) => {
                const usuario = results[0];
                if (err) return res.status(500).json({ error: err });
                if (results.length < 1)
                  return res
                    .status(404)
                    .json({ message: "Tarjeta no encontrada" });
                connection.query(
                  "SELECT * FROM permisos WHERE users_id = ? AND devices_id = ?",
                  [usuario.user_id, device_id],
                  (err, results) => {
                    const date = new Date();
                    const user_date =
                      date.getFullYear() +
                      "-" +
                      (date.getMonth() + 1) +
                      "-" +
                      date.getDate();
                    if (err) return res.status(500).json({ error: err });
                    if (results.length < 1) {
                      connection.query(
                        "INSERT INTO userlogs (user_id, device_id, card_uid, user_date, estado) VALUES (?, ?, ?, ?, ?)",
                        [
                          usuario.user_id,
                          device_id,
                          usuario.card_uid,
                          user_date,
                          "Denegado",
                        ],
                        (err, results) => {
                          if (err) return res.status(500).json({ error: err });
                          return res.status(202).json({
                            message: `Acceso Denegado ${usuario.user_name}`,
                          });
                        }
                      );
                    } else {
                      connection.query(
                        "INSERT INTO userlogs (user_id, device_id, card_uid, user_date, estado) VALUES (?, ?, ?, ?, ?)",
                        [
                          usuario.user_id,
                          device_id,
                          usuario.card_uid,
                          user_date,
                          "Permitido",
                        ],
                        (err, results) => {
                          if (err) res.status(500).json({ error: err });
                          return res.status(200).json({
                            message: `Bienvenido ${usuario.user_name} `,
                          });
                        }
                      );
                    }
                  }
                );
              }
            );
          } catch (err) {
            console.log(err);
          }
        }
      }
    );
  } catch (err) {
    console.log(err);
  }
};
