FROM alpine:3.21
WORKDIR /usr/src/app
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client
RUN apk add mariadb-openrc
# RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
# RUN mkdir /run/openrc/
# RUN touch /run/openrc/softlevel
# RUN openrc

COPY script.sh .
RUN chmod +x script.sh
EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["./script.sh"]