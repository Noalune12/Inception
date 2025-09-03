#!/bin/sh

# if [ ! -f "//var/lib/mysql/ib_buffer_pool" ] ; 
# then
    # Create mysql user (if it doesn't exist)
    addgroup -g 1000 mysql 2>/dev/null || true
    adduser -D -u 1000 -G mysql -s /bin/sh mysql 2>/dev/null || true

    # Create and set permissions for directories
    mkdir -p /var/lib/mysql /run/mysqld
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

    # Initialize database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB directly
    mysqld --user=mysql &
    MYSQL_PID=$!


    # Wait for MySQL to be ready
    echo "Waiting for MariaDB to start..."
    for i in $(seq 1 30); do
        if mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; then
            echo "MariaDB is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done

    # Check if MySQL is actually running
    if ! mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; then
        echo "Failed to start MariaDB"
        exit 1
    fi


    # Now secure the installation
    echo "Securing MariaDB..."
    printf '\n\ny\nmy_new_password\nmy_new_password\ny\ny\ny\ny\n' | mariadb-secure-installation 2>/dev/null

    echo "MariaDB setup complete!"

    # Force root to always use password authentication
    # mysql -u root -p"my_new_password" -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('my_new_password');"
    # mysql -u root -p"my_new_password" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'my_new_password';"
    mysql -u root -p"my_new_password" -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('my_new_password');"
    mysql -u root -p"my_new_password" -e "ALTER USER 'mysql'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('my_new_password');"
    mysql -u root -p"my_new_password" -e "FLUSH PRIVILEGES;"

# fi




# # Create your database
# mysql -u root -p"my_new_password" -e "CREATE DATABASE IF NOT EXISTS myapp;"
# mysql -u root -p"my_new_password" -e "CREATE USER 'appuser'@'%' IDENTIFIED BY 'apppassword';"
# mysql -u root -p"my_new_password" -e "GRANT ALL PRIVILEGES ON myapp.* TO 'appuser'@'%';"
# mysql -u root -p"my_new_password" -e "FLUSH PRIVILEGES;"

# Keep MySQL running in foreground
# wait $MYSQL_PID
/usr/bin/mariadb -p"my_new_password"


# # Wait a bit for MySQL to start
# sleep 5

# # Now run secure installation
# echo -e "\n\ny\nmy_new_password\nmy_new_password\ny\ny\ny\ny" | mariadb-secure-installation

# # Kill bootstrap process
# kill $MYSQL_PID 2>/dev/null || true
# wait $MYSQL_PID 2>/dev/null || true

# # Start MySQL normally
# exec mysqld --user=mysql

# mariadb-install-db --user=mysql --datadir=/var/lib/mysql
# rc-service mariadb start
# echo -e "\n\ny\nmy_new_password\nmy_new_password\ny\ny\ny\ny" | mariadb-secure-installation 
# # mariadb-secure-installation
# # rc-update add mariadb default