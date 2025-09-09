#!/bin/sh 
openssl req -x509 -newkey rsa:4096 -keyout ${SSL_KEY} -out ${SSL_CERT} -sha256 -days 365 -nodes -subj "/CN=lbuisson.42.fr" \
    >/dev/null 2>/dev/null
exec nginx -g "daemon off;"