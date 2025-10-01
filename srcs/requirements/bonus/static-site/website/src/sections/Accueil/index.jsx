import './style.scss';
import Coding from '../../assets/coding.png'

function Accueil () {
    return (
        <section className='accueil-section' id='accueil'>
            <div className='left-side-page'>
                <img src={Coding} alt='icon-coding' className='icon-coding'/>
            </div>
            <div className='right-side-page'>
                <h1 className='my-name'>Lou-Anne Buisson</h1>
                <p className='dev-web'>Développeuse Web</p>
            </div>
        </section>
    )

}

export default Accueil