// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';

const PaymentDetails = ({ paymentId }) => {
    const [paymentDetails, setPaymentDetails] = useState(null);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchPaymentDetails = async () => {
            try {
                const response = await axios.get(`http://localhost:3000/api/payments/payment-details/${paymentId}`);
                setPaymentDetails(response.data);
            } catch (err) {
                setError(err.message);
            }
        };

        fetchPaymentDetails();
    }, [paymentId]);

    if (error) {
        return <div>Error: {error}</div>;
    }

    if (!paymentDetails) {
        return <div>Loading...</div>;
    }

    return (
        <div>
            <h1>Payment Details</h1>
            <p>User ID: {paymentDetails.userId}</p>
            <p>Card Number: {paymentDetails.cardNumber}</p>
            <p>Card Owner: {paymentDetails.cardOwner}</p>
            <p>Expiration Date: {new Date(paymentDetails.expirationDate).toLocaleDateString()}</p>
            <p>CVV Code: {paymentDetails.cvvCode}</p>
        </div>
    );
};

PaymentDetails.propTypes = {
    paymentId: PropTypes.number.isRequired
};

export default PaymentDetails;
