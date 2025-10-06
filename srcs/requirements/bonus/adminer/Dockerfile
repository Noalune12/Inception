FROM alpine:3.21

RUN apk add --no-cache php php-mysqli php-session wget

WORKDIR /var/www/

RUN wget -O adminer.php https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php

EXPOSE 8080

ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "adminer.php"] 