import { Resend } from "resend";
import jwt from "jsonwebtoken";

const resend = new Resend(process.env.RESEND_API_KEY);
const verificationCodes = new Map();

export const resendCode = (req, res) => {
  const { email } = req.body;
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  verificationCodes.set(email, code);

  resend.emails.send({
    from: "onboarding@resend.dev",
    to: email,
    subject: "Nuevo código de verificación",
    html: `<p>Tu nuevo código de verificación es: <strong>${code}</strong></p>`,
  });

  res.json({ message: "Nuevo código de verificación enviado" });
};

export const verifyCode = (req, res) => {
  const { email, code } = req.body;
  console.log(email, code);
  const storedCode = verificationCodes.get(email);

  if (code === storedCode) {
    verificationCodes.delete(email);
    const token = jwt.sign({ email }, "your_jwt_secret", { expiresIn: "1d" });
    res.json({ message: "Verificación exitosa", token });
  } else {
    res.status(400).json({ message: "Código inválido" });
  }
};

export const sendCode = (email) => {
  const code = Math.floor(100000 + Math.random() * 900000).toString();
  verificationCodes.set(email, code);

  resend.emails.send({
    from: "Acme <onboarding@resend.dev>",
    to: email,
    subject: "Código de verificación",
    html: `<p>Tu código de verificación es: <strong>${code}</strong></p>`,
  });
};
