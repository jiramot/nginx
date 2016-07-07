FROM ubuntu:16.04
RUN sed -i -- 's/archive.ubuntu.com/mirror.kku.ac.th/g' /etc/apt/sources.list

MAINTAINER Watchanon Numnam "jiramot@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ARG NGINX_VERSION
ENV NGINX_VERSION=${NGINX_VERSION:-1.11.2} \
    LUA_VERSION=0.10.5 \
    NGINX_DEVEL_KIT_VERSION=0.3.0 \
    LUAJIT_VERSION=2.0.4 \
    NGINX_USER=nginx \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx \
    NGINX_SETUP_DIR=/var/cache/nginx \
    LUAJIT_LIB=/usr/local/lib \
    LUAJIT_INC=/usr/local/include/luajit-2.0

ARG WITH_LUA=true

COPY ./setup.sh ${NGINX_SETUP_DIR}/setup.sh

RUN bash ${NGINX_SETUP_DIR}/setup.sh

ADD ./etc/nginx/conf.d/* /etc/nginx/conf.d/
ADD ./etc/nginx/nginx.conf /etc/nginx

EXPOSE 80 443
CMD nginx -g 'daemon off;'
