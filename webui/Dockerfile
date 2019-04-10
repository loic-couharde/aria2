FROM node:alpine AS build
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

RUN apk update
RUN apk add git python2 make g++

RUN git clone https://github.com/ziahamza/webui-aria2.git

WORKDIR /webui-aria2

RUN npm install

ARG SECRET
COPY ./conf/configuration.js ./src/js/services/configuration.js
COPY ./conf/secret.js ./src/js/services/secret.js
RUN mv ./webpack.config.js ./webpack.config.base.js
COPY ./conf/webpack.config.js ./webpack.config.js

RUN npm run build

FROM nginx:stable AS client

COPY --from=build /webui-aria2/docs /var/www
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD nginx -g 'daemon off;'
