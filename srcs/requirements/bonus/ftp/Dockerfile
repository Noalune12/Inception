FROM alpine:3.21

RUN apk add --no-cache vsftpd

# RUN echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21 21000-21010

COPY script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
