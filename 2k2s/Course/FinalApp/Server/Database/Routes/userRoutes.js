const express = require('express');
const router = express.Router();
const dbSelectProcedures = require('../DatabaseSelectProcedurs');

// Маршрут для получения данных пользователя по ID
router.get('/user-details/:id', async (req, res) => {
    try {
        const userId = parseInt(req.params.id, 10);
        const userDetails = await dbSelectProcedures.getUserDetails(userId);
        res.json(userDetails);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
