FROM alpine:3.21 AS build

RUN apk add --no-cache nodejs npm

COPY /conf/package*.json ./

RUN npm ci

COPY /website/ ./

RUN npm run build


FROM alpine:3.21

RUN apk add --no-cache npm

WORKDIR /app

COPY --from=build /build ./build
COPY --from=build package*.json ./
COPY --from=build /src/ ./
COPY --from=build /public/ ./

RUN npm install -g serve

EXPOSE 3000

ENTRYPOINT ["serve", "-s", "build", "-l", "3000"]