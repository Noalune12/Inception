#!/bin/sh 

set -e

FTP_PWD=$(cat /run/secrets/ftp_pwd)

HOST_IP=$(ip route | awk '/default/ { print $3 }')
echo "pasv_address=${HOST_IP}" >> /etc/vsftpd/vsftpd.conf

echo "Waiting for Wordpress volume to be ready..."
while [ ! -f /var/www/html/.wp-built ]; do
    sleep 2
done
echo "Wordpress is ready, starting FTP"

if ! id "$FTP_USER" &>/dev/null; then
    adduser -D -G www-data -h /var/www/html $FTP_USER
fi
echo "$FTP_USER:$FTP_PWD" | chpasswd 
chown -R $FTP_USER:www-data /var/www/html
chmod -R 755 /var/www/html

exec $@