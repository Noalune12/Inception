# Inception

### Goal
1. use docker compose
2. one Dockerfile per service
3. Docker image -> service -> container

## Introduction
### Container
- paquet de code logiciel qui regroupe tout le code et les dépendances d’une application dans un format standard,
- Il permet une exécution rapide et de fiable dans l’ensemble des environnements informatiques. (executable sur n'importe quel systeme cible -> rend les app portables)
- Un conteneur Docker est un conteneur exécutable populaire léger et autonome, qui comprend tous les éléments nécessaires pour exécuter une application, notamment les bibliothèques, les outils système, le code et le runtime.
- Ce moteur d'exécution de conteneur s'exécute sur le moteur d'un serveur, d'une machine ou d'une instance cloud. Le moteur exécute plusieurs conteneurs en fonction des ressources sous-jacentes disponibles.
- Les conteneurs ne sont pas persistents et sont lances a partir d'image

### Difference between container and VM
- Les 2 rendent nos applications independantes des ressources de notre infrastructure informatique.
- Conteneur :
	- portabilite des applications
	- fonctionnent independemment de la machine sur laquelle il est execute
	- images de conteneur : des fichiers contenant les informations nécessaires à l'exécution de l'application. Les images de conteneur sont en lecture seule et ne peuvent pas être modifiées par le système informatique.
	- plus leger
	- Operating system ???
- VM :
	- copie numerique d'une machine physique.
	- plus volumineux
	- Hypervisor ???

### Docker
- plateforme permettant de lancer certaines applications dans des conteneurs logiciels lancée en 2013
-  Docker utilise le noyau Linux ainsi que ses fonctionnalités pour séparer des processus afin qu'ils s'exécutent de manière indépendante.
- Docker exécute les applications dans des conteneurs et assure la compatibilité et la cohérence dans divers environnements informatiques

### Advantage of Docker
- Une seule couche de système d’exploitation – contrairement aux machines virtuelles traditionnelles, les conteneurs Docker permettent à plusieurs conteneurs logiciels de coexister sur le même système sans nécessiter d’instances de système d’exploitation distinctes.
- Légèreté : comme les conteneurs partagent le noyau du système hôte, ils consomment moins d’espace et nécessitent moins de ressources, tout en offrant des avantages considérables en termes de performances.
- Environnement permettant de gagner du temps – en créant des conteneurs Docker, les développeurs peuvent encapsuler l’ensemble de l’environnement d’exécution. Celui-ci comprend l’application, ses dépendances immédiates, les binaires nécessaires et les fichiers de configuration.
- Plus d’efficacité – Les images de conteneurs Docker sont des instantanés portables et cohérents de l’environnement d’un conteneur. Les applications peuvent être exécutées uniformément à l’aide d’une image de conteneur Docker, quel que soit le lieu ou le moment où elles ont été déployées.


## More about Docker
### Syntax
- INSTRUCTION arguments
- 1st instruction = FROM + specify the base image from which I am building
	- Debian Trixie 13 (testing)
	- Debian Bookworm 12 (stable)
	- Debian Bullseye 11 (oldstable) -> this one
- suite d'instruction afin de creer une image fonctionnelle a partir d'une image de base
	- installation des dependances
	- copie du code
	- configuration de l'environnement
	- commande de lancement de l'application
- [Ecrire un Dockerfile](https://blog.stephane-robert.info/docs/conteneurs/images-conteneurs/ecrire-dockerfile/)
### Key instructions
- CMD : Specify default commands
- FROM : create a new build stage from a base image
- RUN : execute build commands
- COPY : Copy files and directories
- [etc](https://docs.docker.com/reference/dockerfile/#overview)

### Images vs Containers
|      | Image Docker | Conteneur Docker |
| -------- | ------- | ------------------|
| De quoi s'agit-il ?  | Fichier réutilisable et partageable utilisé pour créer des conteneurs. | Une instance d'exécution ; un logiciel intégré. |
| Créé à partir de | Code logiciel, dépendances, bibliothèques et Dockerfile. | Une image. |
| Composition | Couches en lecture seule. | Couches en lecture seule avec une couche de lecture-écriture supplémentaire sur le dessus. |
| Mutabilité | Immuable. S'il y a des modifications, vous devez créer un nouveau fichier. | Mutable ; vous pouvez le modifier au moment de l'exécution si nécessaire. |
| Quand utiliser | Pour stocker les détails de configuration de l'application sous forme de modèle. | Pour exécuter l'application. |

### Docker CLI
- command line interface to interact with Docker containers and manage different aspects of the container ecosystem directly from the command line. (create, start, stop, delete containers)
- Docker build
	- Build an image from Dockerfile (. means the contexte of build - current repo)
	- ``` docker build -t image-name:tag . ```
	- ``` docker build -f Dockerfile.prod -t my-app:production . ```
- Docker run
	- execute a container from image
- Docker ps (list containers)

### Docker volumes
- for persistent data storage (containers are ephemeral by nature, volumes allow to survive container destruction)
- for data sharing between containers and host system
- volumes can be named (```docker volume create app-data && docker run -v app-data:/data my-app```)
- ```docker volume ls```

### Docker networks
- bridge network : Isolated network for containers on the same host
- host network : Container shares the host's network stack directly, uses host's IP
- custom networks : user defined networks

## Docker Compose
### what is it ?
- define and manage multi- containers application in one single configuration file
- microservice communicating with each other
- networks and volumes automated
- easy deployement and reproduction of environment
### file structure of docker-compose.yml
- services : each service = one container
	- build or image
	- ports
	- environment
	- volumes
	- networks
- volumes
- networks
### useful commands
- docker-compose up -d          # Démarrer en arrière-plan
- docker-compose up --build     # Rebuilder les images avant démarrage
- docker-compose down           # Arrêter et supprimer les conteneurs
- docker-compose down -v        # + supprimer les volumes
- docker-compose restart api    # Redémarrer un service spécifique
- bashdocker-compose ps             # Status des services
- docker-compose logs           # Logs de tous les services
- docker-compose logs -f web    # Suivre les logs du service web
- docker-compose exec api bash  # Accéder au conteneur API
- docker-compose pull           # Mettre à jour les images
- bashdocker-compose up --scale web=3    # Démarrer 3 instances du service web
- docker-compose build api          # Rebuilder seulement le service API
- docker-compose config             # Valider la configuration

## Containers

### NGINX
- conf
	- proxy_http_version 1.1; -> use modern version of http
	- proxy_set_header Host $host; -> say to backend service the real domain name
	- proxy_set_header X-Real-IP $remote_addr; -> transmit IP of real visitor (otherwise nginx IP)
	- proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; -> keep history of IP met
	- proxy_set_header X-Forwarded-Proto $scheme;-> say if connexion is http or https

### WORDPRESS
- Ajout de memory limit -> definit quantite maximale de memoire vive qu'unscript php peut utiliser - PHP Fatal error:  Allowed memory size of 134217728 bytes exhausted (tried to allocate 36864 bytes) in phar:///usr/local/bin/wp/vendor/wp-cli/wp-cli/php/WP_CLI/Extractor.php on line 100
- php = server language
	- php83-fpm -> FastCGI -> handle process PHP to serve web request via nginx
	- php83-mysqli -> MySQL interface -> Wordpress can communicate with Mariadb
	- php83-mbstring -> handle strings URF-8 (special characters)
	- php83-ctype -> verif charac types (used for plugin)
	- php83-phar -> archives PHP -> needed for wp commands
	- php83-opcache -> cache bytecode PHP compiled in memory -> improve perf
	- php83-tokenizer -> lexical analysis -> can be needed for themes/plugin on modern frameworks
	php83-redis -> communicate with redis (cache object wordpress)
- adduser -S (system user) -D (no password - cannot connect) -G (group) www-data www
- php-fpm83 -F -> en foreground

### REDIS
- Commands :
	- wp redis status | grep Met
	- redis-cli -h redis ping
	- PING                - test connection
	- INFO stats          - view cache hit/miss stats
	- KEYS *              - list keys (be cautious)
	- DBSIZE              - count keys
	- GET keyname         - get value of key
	- TTL keyname         - check expiration
	- FLUSHDB             - clear current DB
	- QUIT                - exit CLI

### ADMINER
- To get the modif from adminer -> redis needs to be flushed with redis-cli FLUSHALL

### FTP
- standard network protocol used for the transfer of files from one host to another

## LEFT TO CHECK
- Init true in dockercompose
- www.conf (wordpress)
- mariadb-server.cnf (mariadb)
- vsftpd.conf (ftp)