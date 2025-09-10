#!/bin/sh 

mariadb-admin ping --protocol=tcp --host=mariadb -u "$MYSQL_USER" --password="$MYSQL_PASSWORD" --wait >/dev/null 2>/dev/null
if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."

    # Download and configure WordPress
    wp core download --allow-root || true
    wp config create --allow-root \
        --dbhost=mariadb:3306 \
        --dbuser=lbuisson \
        --dbpass=UsTGHe1y0eUD4yBO5Mqe \
        --dbname=wordpress
    wp core install --allow-root \
        --skip-email \
        --url="http://lbuisson.42.fr" \
        --title=Inception \
        --admin_user=lbuisson42 \
        --admin_password=pb9i65XB3dd3Zx4lzoLM \
        --admin_email=lbuisson@gmail.com
    wp option update siteurl http://lbuisson.42.fr --allow-root
    wp option update home http://lbuisson.42.fr --allow-root

    # Create a regular user if it doesn't already exist
    if ! wp user get user42 --allow-root > /dev/null 2>&1; then
        wp user create user42 user@gmail.com --role=author --user_pass=1234 --allow-root
    fi
else
    echo "WordPress is already installed."
fi
exec php-fpm83 -F