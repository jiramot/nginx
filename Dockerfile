FROM ubuntu:16.04
MAINTAINER Watchanon Numnam "jiramot@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ARG NGINX_VERSION
ENV NGINX_VERSION=${NGINX_VERSION:-1.11.2} \
    LUA_VERSION=0.10.5 \
    NGINX_USER=nginx \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx \
    NGINX_SETUP_DIR=/var/cache/nginx

ARG WITH_LUA=true

COPY ./setup.sh ${NGINX_SETUP_DIR}/setup.sh

RUN bash ${NGINX_SETUP_DIR}/setup.sh

EXPOSE 80 443
CMD nginx -g 'daemon off;'
