#!/bin/sh 

set -e
# adduser -D -h /var/www/html ftpuser

echo "Waiting for Wordpress volume to be ready..."
while [ ! -f /var/www/html/.wp-built ]; do
    sleep 2
done
echo "Wordpress is ready, starting FTP"
# sleep 15
adduser -D -G www-data -h /var/www/html ftpuser
# addgroup ftpuser www-data
echo "ftpuser:ftppass" | chpasswd 
# mkdir -p /home/ftpuser/wordpress
chown -R ftpuser:www-data /var/www/html
chmod -R 775 /var/www/html
rm /var/www/html/.wp-built

exec $@