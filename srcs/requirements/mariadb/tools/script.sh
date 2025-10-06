#!/bin/sh 

set -e

MYSQL_ROOT_PWD=$(cat /run/secrets/db_root_pwd)
MYSQL_USER_PWD=$(cat /run/secrets/db_user_pwd)

if [ ! -d "${MYSQL_DATADIR}/mysql" ]; then
    echo "Installing MariaDB.."
    mariadb-install-db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql \
         >/dev/null 2>/dev/null

    mariadbd-safe &

    echo "Waiting for MariaDB to start..."
    for i in $(seq 1 30); do
        if mariadb-admin ping --silent >/dev/null 2>/dev/null; then
            echo "MariaDB is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done

    if ! mariadb-admin ping --silent >/dev/null 2>/dev/null; then
        echo "Failed to start MariaDB"
        exit 1
    fi

    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "DROP USER IF EXISTS '${MYSQL_USER}'@'localhost';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PWD';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "FLUSH PRIVILEGES;"
    mariadb-admin -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" shutdown
fi

exec mariadbd-safe
