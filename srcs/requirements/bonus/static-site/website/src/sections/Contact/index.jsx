import './style.scss';
import React, { useState } from 'react';
// import emailjs from 'emailjs-com';

function Contact () {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [status, setStatus] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!name || !email || !message) {
      setStatus('Veuillez remplir tous les champs.');
      return;
    }

    if (!validateEmail(email)) {
        setStatus('Veuillez entrer une adresse e-mail valide.');
        return;
      }

    try {
      const res = await fetch('/portfolio/api/send-mail', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, email, message })
      });

      const result = await res.json();
      console.log(result);
      if (result.status === 'ok') {
        setStatus('Message envoyé !');
        setName('');
        setEmail('');
        setMessage('');
      } else {
        setStatus('Une erreur est survenue. Veuillez réessayer.');
      }
    } catch (err) {
      console.error(err);
      setStatus('Une erreur est survenue. Veuillez réessayer.');
    }
  }

    // const templateParams = {
    //   from_name: name,
    //   from_email: email,
    //   message: message,
    // };

    // emailjs.send('service_portfolio', 'template_e28p80k', templateParams, '5WikpGOCXRy0R5kwI')
    //   .then((response) => {
    //     setStatus('Message envoyé !');
    //     setName('');
    //     setEmail('');
    //     setMessage('');
    //   })
    //   .catch((error) => {
    //     setStatus('Une erreur est survenue. Veuillez réessayer.');
    //   });


  const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(String(email).toLowerCase());
  };

    return (
        <section className='contact' id='contact'>
              <h2 className="contact-title">Me contacter</h2>
              <p className='contact-text'> N'hésitez pas à me contacter pour toute question ou demande de collaboration.</p>
              <form onSubmit={handleSubmit} className="form-container" noValidate>
                    <div className='form-content'>
                        <div className='form-row'>
                            <div className='form-info'>
                                <label htmlFor="nom">Nom:</label>
                                <input id='nom'
                                    type="text"
                                    value={name}
                                    onChange={(e) => setName(e.target.value)}
                                />
                            </div>
                            <div className='form-info'>
                                <label htmlFor="email">Email:</label>
                                <input id='email'
                                    type="email"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                />
                            </div>
                        </div>
                        <div className='form-info'>
                            <label htmlFor="message">Message:</label>
                            <textarea id='message'
                                value={message}
                                onChange={(e) => setMessage(e.target.value)}
                            ></textarea>
                        </div>
                    </div>
                    <p className='form-message'>{status}</p>
                    <button type="submit" className="submit-button">Envoyer</button>
                </form>
        </section>
    )

}

export default Contact