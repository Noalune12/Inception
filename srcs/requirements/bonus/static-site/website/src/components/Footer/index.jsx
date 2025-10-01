import './style.scss';
import { IoLogoLinkedin } from "react-icons/io5";
import { FaGithub } from "react-icons/fa";


function Footer () {
    return (
        <footer>
            <div className='link-social-media'>
                <a href='https://github.com/Noalune12' target='blank' aria-label="Linkedin"><IoLogoLinkedin/></a>
                <a href='https://www.linkedin.com/in/lou-anne-buisson-b855b19b/' target='blank' aria-label="Github"><FaGithub/></a>
            </div>
            <p>© 2024 Lou-Anne Buisson. All rights reserved</p>
            <a href="https://www.flaticon.com/free-icons/coding" title="coding icons" target='blank'>Coding icons created by edt.im - Flaticon</a>
        </footer>
    )
}

export default Footer