import connection from '../config/db.js';

export const devices = (req, res) => {
  const query = 'SELECT user_id, genere, user_name, user_serial, user_email, card_uid, user_date, is_active, GROUP_CONCAT(device_dep) AS devices FROM permisos JOIN users ON permisos.users_id = users.user_id JOIN devices ON permisos.devices_id = devices.device_id WHERE is_active = 1 GROUP BY users.user_id';
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching user logs:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.json(results);
    console.log(results);
  });
}
