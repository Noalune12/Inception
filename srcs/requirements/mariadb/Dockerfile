FROM alpine:3.21

WORKDIR /usr/src/app

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

COPY /conf/mariadb-server.cnf /etc/my.cnf.d

COPY /tools/script.sh .

RUN chmod +x script.sh

EXPOSE 3306

ENTRYPOINT ["./script.sh"]