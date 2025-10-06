FROM alpine:3.21

RUN apk add --no-cache vsftpd

COPY /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21

COPY /tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
