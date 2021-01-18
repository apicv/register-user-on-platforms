var nodemailer = require('nodemailer');
require('dotenv').config();
email = process.argv[2]
username = process.argv[3]
password = process.argv[4]

var transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  secure: process.env.SMTP_SECURE, // true for 465, false for other ports
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_USER_PASSWD,
  },
});

var mailOptions = {
  from: process.env.SMTP_USER,
  to: email,
  subject: 'Plataformes APICV',
  text: `Primer, has de canviar la teua contrasenya: \n\
        web: usuaris.apicv.net\n\
        usuari: ${username}\n\
        passwd: ${password}\n\
        \n\
Amb açò, ja pots accedir a nextcloud.apicv.net\n\
\n\
Per a canviar la contrasenya del correu:\n\
        web: webmail.apicv.net/admin\n\
        usuari: ${username}@docent.apicv.net\n\
        passwd: ${password}\n\
\n\
Salutacions,\n\
L\'equip d\'APICV`
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
});
