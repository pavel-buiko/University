const express = require('express');
const cors = require('cors');
const dbConnection = require('./Database/DatabaseConnection');
const userRoutes = require('./Database/Routes/userRoutes');
const paymentRoutes = require('./Database/Routes/PaymentRoutes');
const app = express();
const PORT = process.env.PORT || 3000;

// Используем CORS
app.use(cors());

// Используем маршруты
app.use('/api/users', userRoutes);
app.use('/api/payments', paymentRoutes)
// Запуск сервера
app.listen(PORT, async () => {
  try {
    await dbConnection.connectToDB();
    console.log(`Server running on port ${PORT}`);
  } catch (err) {
    console.error('Failed to start server due to database connection error:', err);
  }
});

// Обработка ошибок (если необходимо)
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'Internal Server Error' });
});