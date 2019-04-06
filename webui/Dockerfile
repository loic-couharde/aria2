FROM node:alpine AS build
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

RUN apk update
RUN apk add git python2 make g++

RUN git clone https://github.com/ziahamza/webui-aria2.git
COPY ./conf/configuration.js /webui-aria2/src/js/services/configuration.js

WORKDIR /webui-aria2

RUN npm install
RUN npm run build

FROM nginx:stable AS client

COPY --from=build /webui-aria2/docs /var/www
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD nginx -g 'daemon off;'
