#!/bin/sh 

if [ ! -d "${MYSQL_DATADIR}/mysql" ]; then
    echo "Installing MariaDB.."
    mariadb-install-db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql \
         >/dev/null 2>/dev/null

    mariadbd-safe &

    # Wait for MariaDB to be ready
    echo "Waiting for MariaDB to start..."
    for i in $(seq 1 30); do
        if mariadb-admin ping --silent >/dev/null 2>/dev/null; then
            echo "MariaDB is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done

    # Check if MariaDB is actually running
    if ! mariadb-admin ping --silent >/dev/null 2>/dev/null; then
        echo "Failed to start MariaDB"
        exit 1
    fi

    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "DROP USER IF EXISTS '${MYSQL_USER}'@'localhost';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PWD';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';"

    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost';"

    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD';"
    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT SHUTDOWN ON *.* TO '${MYSQL_USER}'@'%';"
    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT RELOAD ON *.* TO '${MYSQL_USER}'@'%';"


    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "DROP USER IF EXISTS '${MYSQL_ROOT_USER}'@'localhost';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "FLUSH PRIVILEGES;"

    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    # mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "UPDATE mysql.user SET plugin='unix_socket', authentication_string='' WHERE User='root' AND Host='localhost';"

    # mariadb -u ${MYSQL_USER} -p"${MYSQL_USER_PWD}" -e "FLUSH PRIVILEGES;"

    mariadb-admin -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" shutdown
    # mariadb-admin -u ${MYSQL_USER} -p"${MYSQL_USER_PWD}" shutdown
fi


exec mariadbd-safe
