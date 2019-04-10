FROM alpine:latest
MAINTAINER Loïc Couharde <loic.couharde@gmail.com>

RUN apk update
RUN apk add aria2 su-exec
RUN adduser -D aria2

ARG ARIA2_SECRET
ENV ARIA2_SECRET=${ARIA2_SECRET}

COPY ./conf/aria2.conf /etc/aria2/aria2.conf

VOLUME /home/aria2

RUN chown -R aria2:aria2 /home/aria2

EXPOSE 6800

CMD set -xe && su-exec aria2:aria2 aria2c --conf-path=/etc/aria2/aria2.conf --rpc-secret=${ARIA2_SECRET}
