FROM alpine:3.21
WORKDIR /usr/src/app
RUN apk update && apk upgrade && apk add --no-cache nginx openssl
COPY /conf/nginx.conf ../../../etc/nginx
COPY /conf/myconf.conf ../../../etc/nginx/http.d
# COPY /conf/website.conf ../../../etc/nginx/http.d
COPY /tools/script.sh .
RUN chmod +x script.sh
RUN mkdir -p /etc/nginx/ssl
EXPOSE 443
ENTRYPOINT ["./script.sh"]
# CMD ["nginx", "-g", "daemon off;"]

# tini
# docker run -p 8080:443 nginx
# FROM debian:latest
# RUN apt update && apt upgrade && apt install -y nginx