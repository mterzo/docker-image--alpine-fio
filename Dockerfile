# VERSION 0.1
FROM alpine:3.7

MAINTAINER Dmitry Monakhov dmonakhov@openvz.org

ENV FIO_RELEASE=fio-3.2

VOLUME ["/fio/jobs", "/fio/test_dir", "/fio/results"]

# Install build deps + permanent dep: libaio
RUN set -ex \
        && apk add --no-cache --virtual .deps \
            bash \
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
        && git clone --branch=${FIO_RELEASE} https://github.com/axboe/fio /tmp/fio \
        && cd /tmp/fio && ./configure --disable-native && make -j`nproc` && make install && cd \
        && rm -rf /tmp/fio \
        && apk del .dev

WORKDIR /fio/results

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
