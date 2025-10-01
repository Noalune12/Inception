import { Link, useLocation, useNavigate } from 'react-router-dom';
import './style.scss';
import Logo from '../../assets/lab-logo.png';
import React, { useEffect, useState } from 'react';
import Icon from '../../assets/bouton-retour.png';



function Header () {
    const [scrolled, setScrolled] = useState(false);
    const [activeSection, setActiveSection] = useState('accueil');
    const location = useLocation();
    const navigate = useNavigate();



    useEffect(() => {
        // Ajoutez un écouteur d'événement pour détecter le défilement de la page
        window.addEventListener('scroll', handleScroll);

        // Supprimez l'écouteur d'événement lorsque le composant est démonté
        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    });

    // Fonction pour gérer le défilement de la page
    const handleScroll = () => {
        if (window.scrollY > 0) {
            setScrolled(true);
            updateActiveSection();
        } else {
            setActiveSection('accueil');
            setScrolled(false);
        }
    };


    const updateActiveSection = () => {
        const sections = document.querySelectorAll('section');
        let current = '';
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (window.scrollY >= sectionTop - sectionHeight / 2) {
                current = section.id;
            }
        });
        setActiveSection(current);
    };

    const scrollToSection = (id) => {
        const section = document.getElementById(id);
        const headerHeight = document.querySelector('header').offsetHeight;
        const sectionTop = section.offsetTop - headerHeight;
        window.scrollTo({
            top: sectionTop,
            behavior: 'smooth'
        });
    };

    const isHomePage = location.pathname === '/';

    const handleBackClick = () => {
        if (location.pathname.startsWith('/projets/')) {
            window.history.back();
        } else {
            navigate('/');
        } 
    };
      
    return (
        <header className={`${scrolled ? 'scrolled' : ''}`}>
            <Link to="/" className='page-title' onClick={() => window.scrollTo(0, 0)}>
                <img src={Logo} alt="Logo Lab" className='header-logo' />
            </Link>
            {!isHomePage ? (
                <div className='back' onClick={handleBackClick}>
                <img src={Icon} alt='icone-retour'/>
                <p>Retour</p>
                </div>
            ) : (
                <nav>
                    <ul>
                        <li className={activeSection === 'accueil' ? 'active' : ''} onClick={() => scrollToSection('accueil')}>Accueil</li>
                        <li className={activeSection === 'a-propos' ? 'active' : ''} onClick={() => scrollToSection('a-propos')}>A propos</li>
                        <li className={activeSection === 'mes-projets' ? 'active' : ''} onClick={() => scrollToSection('mes-projets')}>Mes projets</li>
                        <li className={activeSection === 'contact' ? 'active' : ''} onClick={() => scrollToSection('contact')}>Contact</li>
                    </ul>
                </nav>
            )}
        </header>
    );
}

export default Header;