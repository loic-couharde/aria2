FROM alpine:latest
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

ARG UID
ARG GID

RUN apk update
RUN apk add aria2 su-exec
RUN addgroup -g ${GID} aria2
RUN adduser -D -u ${UID} -G aria2 aria2

COPY ./conf/aria2.conf /etc/aria2/aria2.conf

VOLUME /home/aria2

EXPOSE 6800

CMD set -xe \
  && chown aria2:aria2 /home/aria2 \
  && su-exec aria2:aria2 aria2c --conf-path=/etc/aria2/aria2.conf --dir=/home/aria2
