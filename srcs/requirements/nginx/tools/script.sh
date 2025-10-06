#!/bin/sh 

set -e


openssl req -x509 -newkey rsa:4096 -keyout ${SSL_KEY} -out ${SSL_CERT} -sha256 -days 365 -nodes -subj "/CN=lbuisson.42.fr" \
    >/dev/null 2>/dev/null

cd ../../../etc/nginx

envsubst '$DOMAIN $SSL_CERT $SSL_KEY' < myconf.conf > out.conf

mv out.conf http.d/myconf.conf

exec nginx -g "daemon off;"