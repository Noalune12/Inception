import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import './style.scss';
import Header from './components/Header';
import Home from './pages/Home'
import Error404 from './pages/Error404';
import Projet from './pages/Projet';
import Footer from './components/Footer';

document.title = "Lou-Anne Buisson, Développeuse Web";


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
     <Router >
      <div className='app-wrapper'>
          <Header />
          <div className='content'>
            <Routes>
              <Route path='/portfolio' element={<Home />}/>
              <Route path="/portfolio/projets/:projetId" element={<Projet />} />
              <Route path="/portfolio/*" element={<Error404 />} />
            </Routes>
          </div>
          <Footer />
        </div>
    </Router>
  </React.StrictMode>
);

