# VERSION 0.1
FROM alpine:edge

MAINTAINER Dmitry Monakhov dmonakhov@openvz.org

ENV FIO_RELEASE=master
ENV ALPINE_TESTING http://nl.alpinelinux.org/alpine/edge/testing

VOLUME ["/fio/jobs", "/fio/test_dir", "/fio/results"]

# Install build deps + permanent dep: libaio
RUN set -ex \
        && echo "${ALPINE_TESTING}" >> /etc/apk/repositories \
        && apk add --no-cache --virtual .deps \
            bash \
            zlib \
            libaio \
            librados \
        && apk --no-cache --virtual .dev add \
            make \
            alpine-sdk \
            zlib-dev \
            libaio-dev \
            librados-dev \
            linux-headers \
            coreutils \
            libaio \
        && git clone --branch=${FIO_RELEASE} https://github.com/axboe/fio /tmp/fio \
        && cd /tmp/fio && ./configure && make -j`nproc` && make install && cd \
        && rm -rf /tmp/fio \
        && apk del .dev

WORKDIR /fio/results

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
