#!/bin/sh 
addgroup -g 82 www-data
adduser -u 82 -D -s /bin/sh -G www-data www-data
chown www-data:www-data /var/www/html/wp-config.php
exec php-fpm83 --nodaemonize --fpm-config /etc/php83/php-fpm.conf