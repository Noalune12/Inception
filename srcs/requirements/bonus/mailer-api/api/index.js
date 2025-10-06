const express = require("express");
const nodemailer = require("nodemailer");

const app = express();
app.use(express.json());

// Protect CORE
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// test route
app.get("/", (req, res) => {
  res.json({ status: "API en ligne ✅" });
});

app.post("/send-mail", async (req, res) => {
  try {
    const { name, email, message } = req.body;
    
    let transporter = nodemailer.createTransport({
      host: "mailhog",
      port: 1025,
      secure: false
    });
    
    await transporter.sendMail({
      from: email,
      to: "louanne.buisson@gmail.com",
      subject: `Message from ${name}`,
      text: message
    });
    
    res.json({ status: "ok" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: "error", message: error.message });
  }
});

app.listen(4000, '0.0.0.0', () => console.log("Mailer APIavailable on port 4000"));