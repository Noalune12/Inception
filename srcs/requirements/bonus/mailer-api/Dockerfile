FROM alpine:3.19 AS deps
RUN apk add --no-cache nodejs npm
WORKDIR /app
COPY package*.json ./
RUN npm install

FROM alpine:3.19
RUN apk add --no-cache nodejs npm
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
EXPOSE 4000
CMD ["node", "index.js"]