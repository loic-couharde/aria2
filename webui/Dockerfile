FROM node:10-alpine AS build
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

RUN apk update
RUN apk add git python2 make g++

RUN git clone https://github.com/ziahamza/webui-aria2.git

WORKDIR /webui-aria2

RUN npm install

ARG ARIA2_SECRET
COPY ./conf/configuration.js ./src/js/services/configuration.js
RUN mv ./webpack.config.js ./webpack.config.base.js
COPY ./conf/webpack.config.js ./webpack.config.js

RUN npm run build

FROM alpine as htpasswd

ARG HTPASSWD_USER
ARG HTPASSWD_PASSWORD

RUN apk add --update apache2-utils
RUN htpasswd -b -c htpasswd ${HTPASSWD_USER} ${HTPASSWD_PASSWORD}

FROM nginx:stable AS client

COPY --from=htpasswd htpasswd /etc/nginx/htpasswd
COPY --from=build /webui-aria2/docs /var/www/webui-aria2
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

VOLUME /var/www/downloads

CMD nginx -g 'daemon off;'
