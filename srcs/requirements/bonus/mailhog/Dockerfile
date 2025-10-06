FROM alpine:3.21

RUN apk add --no-cache wget ca-certificates

RUN wget -q https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -O /usr/local/bin/MailHog \
&& chmod +x /usr/local/bin/MailHog

EXPOSE 1025 8025

ENTRYPOINT ["/usr/local/bin/MailHog"]