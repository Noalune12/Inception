FROM alpine:3.21
RUN apk update && apk upgrade && apk add --no-cache php83 \
    php83-fpm \
    php83-mysqli \
    php83-phar \
    php83-mbstring \
    php83-opcache \


    # redis
    php83-ctype \
    php83-tokenizer \
    php83-redis \
    redis \

    curl \
    mariadb-client 

# Create necessary directories
RUN echo "memory_limit = 512M" >> /etc/php83/php.ini
RUN cd /usr/local/bin && \
    curl -o wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp

# RUN mkdir -p /var/www/html

# Download and install WordPress
# WORKDIR /tmp
# RUN wget https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz && \
#     # mkdir -p /var/www/html/wordpress && \
#     mv wordpress/* /var/www/html/ && \
#     rm -rf /tmp/wordpress /tmp/latest.tar.gz

# Set proper permissions
# RUN chown -R www-data:www-data /var/www/html && \
#     chmod -R 755 /var/www/html

# COPY wp-config.php /var/www/html/wp-config.php
COPY /conf/www.conf /etc/php83/php-fpm.d/.

EXPOSE 9000

WORKDIR /var/www/html

COPY /tools/script.sh .
RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]