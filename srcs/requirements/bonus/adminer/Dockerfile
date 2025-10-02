FROM alpine:3.21

RUN apk add --no-cache php php-mysqli php-session wget

WORKDIR /var/www/

RUN wget -O adminer.php https://www.adminer.org/latest.php 


CMD ["php", "-S", "0.0.0.0:8080", "adminer.php"] 

# To get the modif from adminer -> redis needs to be flushed with redis-cli FLUSHALL