import React from 'react';
import Accueil from '../../sections/Accueil';
import Apropos from '../../sections/A-propos';
import MesProjets from '../../sections/Projets';
import Contact from '../../sections/Contact';


function Home () {
        return (
    <div className='home-page'>
        <Accueil />
        <Apropos />
        <MesProjets />
        <Contact />
    </div>
        );
}

export default Home
