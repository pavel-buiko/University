const express = require('express');
const router = express.Router();
const dbSelectProcedures = require('../DatabaseSelectProcedurs');

// Маршрут для получения данных о платеже по ID
router.get('/address-details/:id', async (req, res) => {
    try {
        const addressId = parseInt(req.params.id, 10);
        const addressDetails = await dbSelectProcedures.getAddressDetails(addressId);
        res.json(addressDetails);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

module.exports = router;
