import connection from '../config/db.js';

export const user_logs = (req, res) => {
  const query = 'SELECT users.user_id,users.user_name,users.user_img,users.user_serial,users.user_email,devices.device_name,userlogs.card_uid,userlogs.estado,userlogs.user_date FROM userlogs JOIN users ON userlogs.user_id = users.user_id JOIN devices ON userlogs.device_id = devices.device_id ORDER BY userlogs.user_date DESC';
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching user logs:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.json(results);
  });
}
