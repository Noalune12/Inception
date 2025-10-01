import './style.scss'


function Error() {
    return (
      <section className='error'>
        <p>Une erreur s'est produite lors du chargement</p>
        <div className='exclamation-background'>
                <div className='exclamation'>!</div>
        </div>      
    </section>
    )
  }
  
  export default Error