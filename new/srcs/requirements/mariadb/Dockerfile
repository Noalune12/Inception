FROM alpine:3.21
# WORKDIR /usr/src/app
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client bash
EXPOSE 3306
COPY tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT [ "script.sh" ]