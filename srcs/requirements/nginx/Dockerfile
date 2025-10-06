FROM alpine:3.21

WORKDIR /usr/src/app

RUN apk update && apk upgrade && apk add --no-cache nginx openssl gettext

COPY /conf/*.conf ../../../etc/nginx

COPY /tools/script.sh .

RUN chmod +x script.sh

RUN mkdir -p /etc/nginx/ssl

EXPOSE 443

ENTRYPOINT ["./script.sh"]
