import fs from "fs";
import connection from "../config/db.js";

function formatImagePath(imagePath) {
  let formattedPath = imagePath.replace(/^app\\/, "");
  formattedPath = formattedPath.replace(/\\/g, "/");

  return formattedPath;
}

// Subir una nueva foto de perfil
export const uploadAdminProfilePic = async (req, res) => {
  try {
    console.log(req.file);
    if (!req.file) {
      return res.status(400).json({ error: "No se ha subido ninguna imagen." });
    }
    const originalPath = req.file.path;
    const imagePath = formatImagePath(originalPath);

    const query = "UPDATE admin SET admin_img = ? WHERE admin_id = ?";
    const id = req.params.id;
    connection.query(query, [imagePath, id], (err, results) => {
      if (err) {
        console.log(err);
        return res
          .status(500)
          .json({ error: err, message: "Error subir la foto de perfil" });
      } else {
        if (results.affectedRows < 1) {
          return res.status(404).json({ message: "Usuario no encontrado" });
        }
        return res
          .status(200)
          .json({ message: "Foto subida exitosamente!", imagePath });
      }
    });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al subir la foto", details: error.message });
  }
};

// Actualizar la foto de perfil existente
export const updateAdminProfilePic = async (req, res) => {
  try {
    const userId = req.params.id;

    const queryOldPath = "SELECT admin_img FROM admin WHERE admin_id = (?)";
    connection.query(queryOldPath, [userId], (err, results) => {
      const oldImagePath = `app/${results[0].admin_img}`;
      console.log(oldImagePath);

      if (oldImagePath && fs.existsSync(oldImagePath)) {
        fs.unlinkSync(oldImagePath);
      }

      const originalPath = req.file.path;
      const imagePath = formatImagePath(originalPath);

      const queryNewPath = "UPDATE admin SET admin_img = ? WHERE admin_id = ?";
      const id = req.params.id;
      connection.query(queryNewPath, [imagePath, id], (err, results) => {
        if (err) {
          console.log(err);
          return res
            .status(500)
            .json({ error: err, message: "Error subir la foto de perfil" });
        } else {
          if (results.affectedRows < 1) {
            return res.status(404).json({ message: "Usuario no encontrado" });
          }
          return res
            .status(200)
            .json({ message: "Foto subida exitosamente!", imagePath });
        }
      });
    });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al actualizar la foto", details: error.message });
  }
};

// Eliminar la foto de perfil
export const deleteAdminProfilePic = async (req, res) => {
  try {
    const userId = req.params.id;
    const imagePath = user.user_img;
    if (imagePath && fs.existsSync(imagePath)) {
      fs.unlinkSync(imagePath);
    }
    res.status(200).json({ message: "Foto eliminada exitosamente" });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error al eliminar la foto", details: error.message });
  }
};
