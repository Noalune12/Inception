import './style.scss';
import Timeline from '../../components/Timeline';
import { FaHtml5, FaCss3, FaJs, FaReact, FaSass, FaNodeJs, FaGit, FaGithub } from 'react-icons/fa';
import LogoExpress from '../../assets/express.svg';
import LogoLighthouse from '../../assets/google-lighthouse.svg';
import LogoC from '../../assets/C.png';
import LogoCPP from '../../assets/C++.png';
import { SiMongodb, SiVisualstudiocode } from "react-icons/si";

const scrollToSection = (id) => {
    const section = document.getElementById(id);
    if (section) {
        const headerHeight = document.querySelector('header').offsetHeight;
        const sectionTop = section.offsetTop - headerHeight;
        window.scrollTo({
            top: sectionTop,
            behavior: 'smooth'
        });
    }
};

function Apropos () {
    return (
        <section className='a-propos' id='a-propos'>
            <div className='a-propos-section'>
                <h2 className='a-propos-title'>A propos</h2>
                <div className='border'>
                <p className='a-propos-texte'>Bienvenue sur mon site !<br/><br/>Après une formation initiale en management international et une première expérience professionnelle en gestion de projets, je me suis reconvertie et dirigée vers le développement web.<br/><br/>Je suis développeuse web junior, passionnée par le web et les nouvelles technologies. Spécialisée dans le front-end, j'ai également des connaissances en back-end, ce qui me donne une vision globale des projets. Mon approche met les besoins et les préférences des utilisateurs au centre de la conception et du développement.
                    <br/><br/>Si vous souhaitez en savoir plus sur moi, vous pouvez consulter mon&nbsp;
                    <a href='https://github.com/Noalune12/' className='link-a-propos' target='blank'>
                        GitHub
                    </a>
                    , et découvrir&nbsp;
                    <a 
                            href='#mes-projets' 
                            className='link-a-propos'
                            onClick={(e) => {
                                e.preventDefault();
                                scrollToSection('mes-projets');
                            }}
                        >
                             mes projets
                    </a>.
                </p>
                </div>
           </div>
           <div className='a-propos-competences'>
                <h2 className='competences-titres'>Mes compétences</h2>
                    <div className='competences-content'>
                        <div className='competences-text'>
                            <h3>Front-End</h3>
                            <div className='competences-list'>
                                <div className='competence-component'>
                                    <FaHtml5/>
                                    <p>HTML</p>
                                </div>
                                <div className='competence-component'>
                                    <FaCss3/>
                                    <p>CSS</p>
                                </div>
                                <div className='competence-component'>
                                    <FaJs/>
                                    <p>JavaScript</p>
                                </div>
                                <div className='competence-component'>
                                    <FaReact/>
                                    <p>React</p>
                                </div>
                                <div className='competence-component'>
                                    <FaSass/>
                                    <p>SASS</p>
                                </div>
                            </div>
                        </div>
                        <div className='competences-text'>
                            <h3>Back-End</h3>
                            <div className='competences-list'>
                                <div className='competence-component'>
                                    <FaNodeJs/>
                                    <p>Node.js</p>
                                </div>
                                <div className='competence-component'>
                                    <img src={LogoExpress} alt='express-logo' className='express-logo'/>
                                    <p>Express.js</p>
                                </div>
                                <div className='competence-component'>
                                    <SiMongodb/>
                                    <p>MongoDB</p>
                                </div>
                                <div className='competence-component'>
                                    <SiMongodb/>
                                    <p>Mongoose</p>
                                </div>
                            </div>
                        </div>
                        <div className='competences-text'>
                            <h3>Outils</h3>
                            <div className='competences-list'>
                                <div className='competence-component'>
                                    <SiVisualstudiocode/>
                                    <p>Visual Studio Code</p>
                                </div>
                                <div className='competence-component'>
                                    <FaGit/>
                                    <p>Git</p>
                                </div>
                                <div className='competence-component'>
                                    <FaGithub/>
                                    <p>Github</p>
                                </div>
                                <div className='competence-component'>
                                    <img src={LogoLighthouse} alt='lighthouse-logo' className='lighthouse-logo'/>
                                    <p>Google Lighthouse</p>
                                </div>
                            </div>
                        </div>
                       <div className='competences-text'>
                            <h3>Langages de programmation</h3>
                            <div className='competences-list'>
                                <div className='competence-component'>
                                    <img src={LogoC} alt='C-logo' className='C-logo'/>
                                    <p>C</p>
                                </div>
                                <div className='competence-component'>
                                    <img src={LogoCPP} alt='CPP-logo' className='CPP-logo'/>
                                    <p>C++</p>
                                </div>
                            </div>
                        </div>
                    </div>
           </div>
           <div className='a-propos-parcours'>
                <h2 className='parcours-title'>Mon parcours</h2>
                <Timeline/>
            </div>
        </section>
    )

}

export default Apropos