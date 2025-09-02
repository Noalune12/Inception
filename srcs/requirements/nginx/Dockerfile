FROM alpine:3.21
# FROM debian:latest
WORKDIR /usr/src/app
# tiny
RUN apk update && apk upgrade && apk add nginx openssl
COPY nginx.conf ../../../etc/nginx
COPY script.sh .
RUN chmod +x script.sh
RUN mkdir -p /etc/nginx/ssl
# RUN apt update && apt upgrade && apt install -y nginx
EXPOSE 443
CMD ["./script.sh"]

# docker run -p 8080:443 nginx