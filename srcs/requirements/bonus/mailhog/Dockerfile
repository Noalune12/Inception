FROM alpine:3.19

RUN apk add --no-cache wget ca-certificates

RUN wget -q https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -O /usr/local/bin/MailHog \
&& chmod +x /usr/local/bin/MailHog

# RUN wget -q https://github.com/axllent/mailpit/releases/download/v1.20.5/mailpit-linux-amd64.tar.gz \
#     && tar -xzf mailpit-linux-amd64.tar.gz -C /usr/local/bin \
#     && rm mailpit-linux-amd64.tar.gz \
#     && chmod +x /usr/local/bin/mailpit

EXPOSE 1025 8025

CMD ["/usr/local/bin/MailHog"]
# CMD ["mailpit"]