FROM alpine:3.21
WORKDIR /usr/src/app
COPY script.sh .
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client
RUN chmod +x script.sh
EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["./script.sh"]

# docker run --name some-mariadb -e MARIADB_ROOT_PASSWORD=helloeverybody -p 3306:3306 mariadb:latest
# docker exec -it <container_name> mariadb -u root -p
# SELECT user, host FROM mysql.user;
# SHOW DATABASES;
# USE database_name;
# SHOW TABLES;
# CREATE TABLE test (id INT, name VARCHAR(50));
# INSERT INTO test VALUES (1, 'Hello World');
# SELECT * FROM test;

# Database need to be persistent?

# mysql -u root - Connect as root user
# -e "SELECT 1;" - Execute this SQL command and exit

# SELECT 1 is a simple test query that always returns 1
# It's the fastest way to test if database is responsive

# >/dev/null - Redirect normal output to nowhere (hide it)
# 2>&1 - Redirect error messages to the same place (hide errors too)