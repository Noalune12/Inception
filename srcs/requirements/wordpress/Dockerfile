FROM alpine:3.21

RUN apk add --no-cache php83 \
    php83-fpm \
    php83-mysqli \
    php83-phar \
    php83-mbstring \
    php83-opcache \
    php83-ctype \
    php83-tokenizer \
    php83-redis \
    redis \
    curl \
    wget \
    mariadb-client 

RUN echo "memory_limit = 512M" >> /etc/php83/php.ini
RUN cd /usr/local/bin && \
    curl -o wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp
RUN cd -

COPY /conf/www.conf /etc/php83/php-fpm.d/.

EXPOSE 9000

WORKDIR /var/www/html

COPY /tools/script.sh .

RUN chmod +x script.sh

RUN adduser -S -D -G www-data www

ENTRYPOINT ["./script.sh"]