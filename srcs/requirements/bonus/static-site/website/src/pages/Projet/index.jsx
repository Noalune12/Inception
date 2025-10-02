import './style.scss';
import { useFetch } from '../../utils/usefetch';
import { useEffect } from 'react';
import Loading from '../../components/Loading';
import Error from '../../components/Error';
import Error404 from '../Error404';
import { useParams } from 'react-router-dom';

function Projet () {
    const projets = useFetch(window.location.origin + '/portfolio/data.json')
    const {projetId} = useParams();

    useEffect(() => {
        window.scrollTo(0, 0);
      }, []);

    let thisProjet
    if(projets.data) {
        thisProjet = projets.data.find(
            (projet) => projet.id === projetId
        )
    }
    if(projets.isLoading) {
        return <Loading />;
    }
    if (projets.error) {
        return <Error />;
    }
    if(!thisProjet) {
        return <Error404 />
    }

    const handleGithubLinkClick = () => {
        if (thisProjet && thisProjet.github) {
            window.open(thisProjet.github, '_blank'); 
        }
      };

      const handleSiteLinkClick = () => {
        if (thisProjet && thisProjet.link) {
            window.open(thisProjet.link, '_blank'); 
        }
      };

      
    return (
        <div className='project'>
            <h1>{thisProjet.title}</h1>
            <div className='project-info'>
            <div className='project-img'>
                <img src={thisProjet.cover} alt='project-img' />
            </div>
            <div className='project-tag-link'>
                 <h2>{thisProjet.subtitle}</h2>
                <div className='project-tag'>
                        {thisProjet.tags.map((tag, index) =>
                        <p key={`${tag}-${index}`}>{tag}</p>)}
                </div>
                <div className='project-link'>
                    <button onClick={handleGithubLinkClick}>Consulter le code</button>
                    {thisProjet.link && (<button onClick={handleSiteLinkClick}>Voir le site</button>)}
                </div>
            </div>
            </div>
            <div className='project-descr-skills'>
                <div className='project-descr'>
                    <h3>Description</h3>
                    {thisProjet.description.map((part, index) => (
                    <span key={index} style={{ fontWeight: part.bold ? 'bold' : 'normal' }}>
                    {part.text}
                    </span>
                    ))}
                </div>
                <div className='project-skills'>
                    <h3>Compétences</h3>
                    <ul>
                        {thisProjet.skills.map((skill, index) =>
                        <li key={`${skill}-${index}`}>{skill}</li>)}
                    </ul>
                </div>
            </div>
            {thisProjet.problem && (
            <>
            <div className='project-problem'>
                <h3>Problématique rencontrée</h3>
                <p>{thisProjet.problem}</p>
            </div>
            </>
            )}

        </div>
    )

}

export default Projet