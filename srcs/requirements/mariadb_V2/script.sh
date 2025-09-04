#!/bin/sh 

# # mkdir /run/openrc/
# # touch /run/openrc/softlevel
# # openrc
# # mariadb-install-db --user=root --ldata=/var/lib/mysql
# # mkdir /run/mysqld
# # sed -i 's:command_args":command_args"--user=root :' /etc/init.d/mariadb
# # echo "[mysqld]" >> /etc/my.cnf
# # echo "skip-networking=0" >> /etc/my.cnf
# # echo "skip-bind-address" >> /etc/my.cnf
# # # Start service
# # rc-service mariadb start

# /usr/bin/mysql_install_db --user=mysql
# mariadbd-safe --datadir="/var/lib/mysql"

if [ ! -d "${MYSQL_DATADIR}/${MYSQL_DATABASE}" ]; then
    echo "installing .."
    mariadb-install-db --user=${MYSQL_USER} --datadir="${MYSQL_DATADIR}"

    mariadbd-safe --datadir="${MYSQL_DATADIR}" &

    # echo "Waiting for MariaDB to start..."
    # until mariadb-admin ping --silent; do
    #     sleep 1
    # done

    # Wait for MySQL to be ready
    echo "Waiting for MariaDB to start..."
    for i in $(seq 1 30); do
        if mariadb -u ${MYSQL_ROOT_USER} -e "SELECT 1;" >/dev/null 2>&1; then
            echo "MariaDB is ready!"
            break
        fi
        echo "Waiting... ($i/30)"
        sleep 1
    done

    # Check if MySQL is actually running
    if ! mariadb -u ${MYSQL_ROOT_USER} -e "SELECT 1;" >/dev/null 2>&1; then
        echo "Failed to start MariaDB"
        exit 1
    fi

    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "ALTER USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PWD}';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost'";
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';"
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "ALTER USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PWD}';"
    # CREATE DATABASE + CREATE USERS
    mariadb -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" -e "FLUSH PRIVILEGES;"

    mariadb-admin -u ${MYSQL_ROOT_USER} -p"${MYSQL_ROOT_PWD}" shutdown
fi


exec mariadbd-safe --datadir="${MYSQL_DATADIR}"
# /usr/bin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid

# exec mysqld --user=mysql