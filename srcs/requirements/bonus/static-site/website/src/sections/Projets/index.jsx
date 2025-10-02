import './style.scss';
import Card from '../../components/Card';
import { useFetch } from '../../utils/usefetch';
import Loading from '../../components/Loading';
import Error from '../../components/Error';


function MesProjets () {
    const projets = useFetch(window.location.origin + '/portfolio/data.json')
    if(projets.isLoading) {
        return <Loading />;
    }
    if (projets.error) {
        return <Error />;
    }

    return (
        <section className='mes-projets' id='mes-projets'>
            <h2 className='mes-projets-title'>Mes projets</h2>
            <div className='projects-cards-container'>
            {projets.data.map((projet) => (
                <Card
                    key={projet.id}
                    link={`/portfolio/projets/${projet.id}`}
                    title={projet.title}
                    cover={projet.cover}
                    tags={projet.tags}
                />
            ))}
        </div>     
        </section>
    )

}

export default MesProjets