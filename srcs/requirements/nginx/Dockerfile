FROM alpine:3.21
WORKDIR /usr/src/app
COPY . .
RUN apk update && apk upgrade && apk add nginx
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]

# docker run -p 80:80 nginx