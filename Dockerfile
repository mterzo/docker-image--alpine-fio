# VERSION 0.1
FROM alpine:3.7

MAINTAINER Dmitry Monakhov dmonakhov@openvz.org

ENV FIO_RELEASE=fio-3.6

# Install build deps + permanent dep: libaio
RUN set -ex \
        && apk add --no-cache --virtual .deps \
            zlib \
            libaio \
        && apk --no-cache --virtual .dev add \
            make \
            alpine-sdk \
            zlib-dev \
            libaio-dev \
            linux-headers \
            coreutils \
            libaio \
        && git clone --branch=${FIO_RELEASE} https://github.com/axboe/fio \
        && cd fio && ./configure --disable-native && make -j`nproc` && make install && cd .. \
        && rm -rf fio \
        && apk del .dev
