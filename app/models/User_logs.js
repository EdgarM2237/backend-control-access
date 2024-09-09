import connection from '../config/db.js';

export const user_logs = (req, res) => {
  const query = 'SELECT username, device_dep, card_uid, checkindate, id FROM users_logs ORDER BY checkindate DESC';
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching user logs:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.json(results);
  });
}
