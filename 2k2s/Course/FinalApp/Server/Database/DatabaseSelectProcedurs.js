const oracledb = require('oracledb');
const { connectToDB } = require('./DatabaseConnection');

async function getUserDetails(userId) {
    const conn = await connectToDB();
    const result = await conn.execute(
        `BEGIN get_user_details(:userId, :firstName, :lastName, :email, :password, :age, :role); END;`,
        {
            userId: { dir: oracledb.BIND_IN, val: userId },
            firstName: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 30 },
            lastName: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 50 },
            email: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 100 },
            password: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
            age: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
            role: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 10 }
        }
    );
    return {
        firstName: result.outBinds.firstName,
        lastName: result.outBinds.lastName,
        email: result.outBinds.email,
        password: result.outBinds.password,
        age: result.outBinds.age,
        role: result.outBinds.role
    };
}

async function getPaymentDetails(paymentId) {
    const conn = await connectToDB();
    const result = await conn.execute(
        `BEGIN get_payment_details(:paymentId, :userId, :cardNumber, :cardOwner, :expirationDate, :cvvCode); END;`,
        {
            paymentId: { dir: oracledb.BIND_IN, val: paymentId },
            userId: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
            cardNumber: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 19 },
            cardOwner: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 100 },
            expirationDate: { dir: oracledb.BIND_OUT, type: oracledb.DATE },
            cvvCode: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        }
    );
    return {
        userId: result.outBinds.userId,
        cardNumber: result.outBinds.cardNumber,
        cardOwner: result.outBinds.cardOwner,
        expirationDate: result.outBinds.expirationDate,
        cvvCode: result.outBinds.cvvCode
    };
}

async function getAddressDetails(addressId) {
    let connection;
    try {
      connection = await connectToDB();
      const result = await connection.execute(
        `BEGIN
           get_address_details(:addressId, :streetTitle, :streetAddress, :city, :state, :postalCode, :country, :apartmentNumber);
         END;`,
        {
          addressId: { dir: oracledb.BIND_IN, val: addressId },
          streetTitle: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 50 },
          streetAddress: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 5 },
          city: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 50 },
          state: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 50 },
          postalCode: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 7 },
          country: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 50 },
          apartmentNumber: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        }
      );
      return {
        streetTitle: result.outBinds.streetTitle,
        streetAddress: result.outBinds.streetAddress,
        city: result.outBinds.city,
        state: result.outBinds.state,
        postalCode: result.outBinds.postalCode,
        country: result.outBinds.country,
        apartmentNumber: result.outBinds.apartmentNumber
      };
    } catch (err) {
      console.error(err);
      throw err;
    } 
  }
// Получение данных о бронировании по ID
async function getBookingById(bookingId) {
  const conn = await connectToDB();
  const result = await conn.execute(
      `BEGIN get_booking_by_id(:bookingId, :userId, :propertyId, :paymentId, :checkIn, :checkOut, :guests, :totalPrice, :status); END;`,
      {
          bookingId: { dir: oracledb.BIND_IN, val: bookingId },
          userId: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
          propertyId: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
          paymentId: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
          checkIn: { dir: oracledb.BIND_OUT, type: oracledb.DATE },
          checkOut: { dir: oracledb.BIND_OUT, type: oracledb.DATE },
          guests: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
          totalPrice: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
          status: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 20 }
      }
  );
  return {
      userId: result.outBinds.userId,
      propertyId: result.outBinds.propertyId,
      paymentId: result.outBinds.paymentId,
      checkIn: result.outBinds.checkIn,
      checkOut: result.outBinds.checkOut,
      guests: result.outBinds.guests,
      totalPrice: result.outBinds.totalPrice,
      status: result.outBinds.status
  };
}

// Получение данных о бронированиях по ID пользователя
async function getBookingsByUserId(userId) {
  const conn = await connectToDB();
  const result = await conn.execute(
      `BEGIN get_bookings_by_user_id(:userId, :bookings); END;`,
      {
          userId: { dir: oracledb.BIND_IN, val: userId },
          bookings: { dir: oracledb.BIND_OUT, type: oracledb.CURSOR }
      }
  );
  // Обработка курсора (result.outBinds.bookings)
  const bookings = [];
  while ((await result.outBinds.bookings.getRow()) !== false) {
      bookings.push(result.outBinds.bookings.getRow());
  }
  return bookings;
}

module.exports = {
    getUserDetails,
    getPaymentDetails,
    getAddressDetails,
    getBookingById,
    getBookingsByUserId
};
