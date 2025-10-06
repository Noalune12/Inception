FROM alpine:3.21 AS build

RUN apk add --no-cache nodejs npm

WORKDIR /app

COPY /conf/package*.json ./

RUN npm install

FROM alpine:3.21

RUN apk add --no-cache nodejs npm

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules

COPY /api/index.js .

EXPOSE 4000

ENTRYPOINT ["node", "index.js"]