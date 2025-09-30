#!/bin/sh 

mariadb-admin ping --protocol=tcp --host=mariadb -u "$MYSQL_USER" --password="$MYSQL_PASSWORD" --wait >/dev/null 2>/dev/null
if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."

    # Download and configure WordPress
    wp core download --allow-root || true
    wp config create --allow-root \
        --dbhost=mariadb:3306 \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_USER_PWD} \
        --dbname=${MYSQL_DATABASE}
    wp core install --allow-root \
        --skip-email \
        --url="http://$DOMAIN" \
        --title=Inception \
        --admin_user=${WP_ADMIN} \
        --admin_password=${WP_ADMIN_PWD} \
        --admin_email=${WP_ADMIN_MAIL}
    wp option update siteurl http://$DOMAIN --allow-root
    wp option update home http://$DOMAIN --allow-root

    # Create a regular user if it doesn't already exist
    if ! wp user get $WP_USER --allow-root > /dev/null 2>&1; then
        wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PWD --allow-root
    fi
else
    echo "WordPress is already installed."
fi
exec php-fpm83 -F