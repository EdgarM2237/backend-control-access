import jwt from "jsonwebtoken";
import cookieParser from "cookie-parser";

// Middleware para verificar el token JWT
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res.status(401).json({ message: "Token no proporcionado" });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ message: "Token no válido" });
    }

    req.user = user;
    next();
  });
};

// Middleware para verificar la cookie JWT activa
const authenticateTokenFromCookie = async (req, res, next) => {
  const token = await req.cookies.jwt;
  console.log(req.cookies);

  if (!token) {
    return res
      .status(401)
      .json({ message: "No se encontró el token en las cookies" });
  }

  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ message: "Token no válido" });
    }

    req.user = user;
    next();
  });
};

export { authenticateToken, authenticateTokenFromCookie };
