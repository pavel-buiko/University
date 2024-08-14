const express = require('express');
const router = express.Router();
const dbSelectProcedures = require('../DatabaseSelectProcedurs');

// Маршрут для получения данных о платеже по ID
router.get('/payment-details/:id', async (req, res) => {
    try {
        const paymentId = parseInt(req.params.id, 10);
        const paymentDetails = await dbSelectProcedures.getPaymentDetails(paymentId);
        res.json(paymentDetails);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
