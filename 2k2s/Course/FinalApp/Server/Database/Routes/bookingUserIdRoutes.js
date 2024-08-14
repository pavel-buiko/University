const express = require('express');
const router = express.Router();
const dbSelectProcedures = require('../DatabaseSelectProcedurs');

// Маршрут для получения данных о бронированиях по ID пользователя
router.get('/bookings/user/:userId', async (req, res) => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const bookings = await dbSelectProcedures.getBookingsByUserId(userId);
    res.json(bookings);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;