FROM alpine:3.21 AS build

RUN apk add --no-cache nodejs npm

COPY /conf/package*.json ./

RUN npm ci

COPY /website/ ./

RUN npm run build



FROM alpine:3.21

RUN apk add --no-cache npm

WORKDIR /app

# COPY /conf/package*.json ./

# RUN npm ci

# COPY /website/ ./

# RUN npm run build

COPY --from=build /build ./build
COPY --from=build package*.json ./
COPY --from=build /src/ ./
COPY --from=build /public/ ./

RUN npm install -g serve

EXPOSE 3000 6000

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

