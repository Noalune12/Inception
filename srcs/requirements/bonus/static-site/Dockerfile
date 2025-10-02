FROM alpine:3.21

RUN apk add --no-cache nodejs npm

WORKDIR /app

COPY /conf/package*.json ./

RUN npm ci

COPY /website/ ./

RUN npm run build

RUN npm install -g serve

EXPOSE 3000

ENTRYPOINT ["serve", "-s", "build", "-l", "3000"]

# Modification
# in package.json ->   "homepage": "/portfolio/",
# in index.js ->               <Route path='/portfolio' element={<Home />}/>
#               <Route path="/portfolio/projets/:projetId" element={<Projet />} />
# in components-header ->     const isHomePage = location.pathname === '/portfolio/';
                          # <Link to="/portfolio/" className='page-title' onClick={() => window.scrollTo(0, 0)}>

# in sections-projets ->     const projets = useFetch(window.location.origin + '/portfolio/data.json')
#                                               link={`/portfolio/projets/${projet.id}`}
# in pages-projet ->     const projets = useFetch(window.location.origin + '/portfolio/data.json')

