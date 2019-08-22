FROM node:10-alpine AS build
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

RUN apk update
RUN apk add git python2 make g++

RUN git clone https://github.com/ziahamza/webui-aria2.git

WORKDIR /webui-aria2

RUN npm install
RUN npm run build

FROM alpine as htpasswd

ARG HTPASSWD_USER
ARG HTPASSWD_PASSWORD

RUN apk add --update apache2-utils
RUN htpasswd -b -c htpasswd ${HTPASSWD_USER} ${HTPASSWD_PASSWORD}

FROM alpine:latest as certificate

ARG CERT_DOMAIN
ARG CERT_PASSWORD

RUN apk add --no-cache openssl

RUN openssl genrsa -des3 -passout pass:${CERT_PASSWORD} -out cert.pass.key 2048
RUN openssl rsa -passin pass:${CERT_PASSWORD} -in cert.pass.key -out cert.key
RUN rm cert.pass.key
RUN openssl req -new -passout pass:${CERT_PASSWORD} -key cert.key -out cert.csr \
    -subj "/C=SS/ST=SS/L=Gotham City/O=Loïc Couharde/CN=${CERT_DOMAIN}"
RUN openssl x509 -req -sha256 -days 365 -in cert.csr -signkey cert.key -out cert.crt

FROM nginx:stable AS client

COPY --from=htpasswd htpasswd /etc/nginx/htpasswd
COPY --from=build /webui-aria2/docs /var/www/webui-aria2
COPY --from=certificate cert.key cert.crt /etc/nginx/ssl/
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/downloads

CMD nginx -g 'daemon off;'
