#!/bin/sh 

rm -f .wp-built
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

# wp redis status | grep Met
# redis-cli -h redis ping
# PING                # test connection
# INFO stats          # view cache hit/miss stats
# KEYS *              # list keys (be cautious)
# DBSIZE              # count keys
# GET keyname         # get value of key
# TTL keyname         # check expiration
# FLUSHDB             # clear current DB
# QUIT                # exit CLI