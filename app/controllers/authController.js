import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import User_action from "../models/User_actions.js";
import { serialize } from "cookie";

export const register = (req, res) => {
  const { username, email, password } = req.body;
  bcrypt.hash(password, 10, (err, hashedPassword) => {
    if (err) return res.status(500).json({ error: err });
    const newUser = { username, email, password: hashedPassword };
    User_action.create(newUser, (err, result) => {
      if (err) return res.status(500).json({ error: err });
      res.status(201).json({ message: "User registered successfully!" });
    });
  });
};

export const login = (req, res) => {
  const { email, password } = req.body;
  console.log(email, password);
  User_action.findByEmail(email, (err, users) => {
    if (err) return res.status(500).json({ error: err });
    if (users.length === 0)
      return res.status(400).json({ message: "Usuario no encontrado!" });
    const user = users[0];
    bcrypt.compare(password, user.admin_pwd, (err, isMatch) => {
      if (err) return res.status(500).json({ error: err });

      if (!isMatch)
        return res.status(400).json({ message: "Contraseña incorrecta!" });

      const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
        expiresIn: "1h",
      });
      const cookieoption = {
        expires: new Date(
          Date.now() + process.env.JWT_COOKIE_EXPIRATION * 24 * 60 * 60 * 1000
        ),
        path: "/",
        domain: "localhost",
      };
      const serialized = serialize("jwt", token, cookieoption);
      res
        .setHeader("Set-Cookie", serialized)
        .status(200)
        .json({ message: "Sesion iniciada!", serialized, redirected: "/" });
    });
  });
};
