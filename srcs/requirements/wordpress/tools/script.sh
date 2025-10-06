#!/bin/sh 

set -e

WP_ADMIN_PWD=$(cat /run/secrets/wp_admin_pwd)
WP_USER_PWD=$(cat /run/secrets/wp_user_pwd)
MYSQL_USER_PWD=$(cat /run/secrets/db_user_pwd)

rm -f .wp-built

mariadb-admin ping --protocol=tcp --host=mariadb -u "$MYSQL_USER" --password="$MYSQL_USER_PWD" --wait >/dev/null 2>/dev/null

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."

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

    if ! wp user get $WP_USER --allow-root > /dev/null 2>&1; then
        wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PWD --allow-root
    fi

    if [ ! -d /var/www/html/wp-content/themes/blocksy ]; then
        wp theme install blocksy --activate --allow-root --path=/var/www/html
    fi
    wp theme activate blocksy --allow-root --path=/var/www/html

    wp post create --post_title="Want to see something else ?" \
        --post_content="Visit my portfolio <a href='https://lbuisson.42.fr/portfolio'>here</a>." \
        --post_status=publish \
        --allow-root

    wp post create --post_title="What can you check ?" \
    --post_content="$(cat checklist.html)" \
    --post_status=publish \
    --allow-root
    
    wp plugin install redis-cache --activate --allow-root

    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp redis enable --allow-root

else
    echo "WordPress is already installed."
fi

chown -R www:www-data /var/www/html
touch .wp-built

exec php-fpm83 -F

