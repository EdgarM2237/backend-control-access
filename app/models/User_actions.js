import db from '../config/db.js';

const User_action = {
    create: (userData, callback) => {
        const { username, email, password } = userData;
        db.query('INSERT INTO admin (admin_name, admin_email, admin_pwd) VALUES (?, ?, ?)', [username, email, password], callback);
    },
    findByEmail: (email, callback) => {
        db.query('SELECT * FROM admin WHERE admin_email = ?', [email], callback);
    }
};

export default User_action;
