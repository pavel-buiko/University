// eslint-disable-next-line no-unused-vars
import React, {useState, useEffect} from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
const UserDetails = ({ userId }) => {
    const [userDetails, setUserDetails] = useState(null);
    const [error, setError] = useState(null);
    useEffect(() => {
        const fetchUserDetails = async () => {
            try {
                const response = await axios.get(`http://localhost:3000/api/users/user-details/${userId}`);
                setUserDetails(response.data);
            } catch (err) {
                setError(err.message);
            }
        };
        fetchUserDetails();
    }, [userId]);

    if (error) {
        return <div>Error: {error}</div>;
    }

    if (!userDetails) {
        return <div>Loading...</div>;
    }
    return (
        <div>
            <h1>User Details</h1>
            <p>First Name: {userDetails.firstName}</p>
            <p>Last Name: {userDetails.lastName}</p>
            <p>Email: {userDetails.email}</p>
            <p>Password: {userDetails.password}</p>
            <p>Age: {userDetails.age}</p>
            <p>Role: {userDetails.role}</p>
        </div>
    );
};
// Определите типы пропсов
UserDetails.propTypes = {
    userId: PropTypes.number.isRequired
};

export default UserDetails;
