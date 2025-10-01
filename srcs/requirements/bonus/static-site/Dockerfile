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