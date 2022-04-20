FROM --platform=linux/amd64 nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY assets assets
COPY va-schoell.de.crt /etc/nginx/va-schoell.de.crt
COPY va-schoell.de.key /etc/nginx/va-schoell.de.key
COPY va-schoell.de.p12 /etc/nginx/va-schoell.de.p12