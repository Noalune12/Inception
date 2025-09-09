FROM alpine:3.21
RUN apk update && apk upgrade && apk add --no-cache php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-zlib \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-xmlreader \
    php83-ctype \
    php83-session \
    php83-mbstring \
    php83-gd \
    php83-zip \
    php83-opcache \
    php83-fileinfo \
    php83-tokenizer \
    php83-simplexml \
    php83-xmlwriter \
    curl \
    wget \
    unzip


# Create PHP-FPM user
# RUN addgroup -g 82 www-data && \
#     adduser -u 82 -D -s /bin/sh -G www-data www-data

# Create necessary directories
RUN mkdir -p /var/www/html /var/log/php83 /run/php-fpm83
RUN mkdir -p /run/php && adduser -D -g 'www' www
# Download and install WordPress
WORKDIR /tmp
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mkdir -p /var/www/html/wordpress && \
    mv wordpress/* /var/www/html/wordpress/ && \
    rm -rf /tmp/wordpress /tmp/latest.tar.gz

# Set proper permissions
# RUN chown -R www-data:www-data /var/www/html && \
#     chmod -R 755 /var/www/html

COPY wp-config.php /var/www/html/wordpress/wp-config.php
COPY www.conf /etc/php83/php-fpm.d/.

EXPOSE 9000

WORKDIR /var/www/html
# CMD ["php-fpm83", "-R", "--nodaemonize", "--fpm-config", "/etc/php83/php-fpm.conf"]

COPY script.sh .


RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]