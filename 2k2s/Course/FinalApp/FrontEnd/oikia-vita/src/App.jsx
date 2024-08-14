// eslint-disable-next-line no-unused-vars
import React,  { useState } from 'react';
import UserDetails from './components/UserDetails';
import PaymentDetails from './components/PaymentRoutes';
function App() {
      return (
          <div>
              <h1>My App</h1>
              <UserDetails userId={1} />
              <PaymentDetails paymentId={1}/>
          </div>
      )
}
export default App;