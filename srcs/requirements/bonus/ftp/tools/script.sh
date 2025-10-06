#!/bin/sh 

set -e

FTP_PWD=$(cat /run/secrets/ftp_pwd)

echo "Waiting for Wordpress volume to be ready..."
while [ ! -f /var/www/html/.wp-built ]; do
    sleep 2
done
echo "Wordpress is ready, starting FTP"

adduser -D -G www-data -h /var/www/html $FTP_USER
echo "$FTP_USER:$FTP_PWD" | chpasswd 
chown -R ftpuser:www-data /var/www/html
chmod -R 755 /var/www/html
rm /var/www/html/.wp-built

exec $@