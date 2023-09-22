FROM davidzapata/php-composer-alpine:8.2

LABEL maintainer="jordan@libertyware.co.uk"
LABEL version="v1.6.1-beta-3"

# Define ARG for DEFAULT_VERSION
ARG DEFAULT_VERSION="v1.6.1-beta-3"
# Define ENV for VERSION with default value set to DEFAULT_VERSION
ENV VERSION=${DEFAULT_VERSION}

ENV INVOICEPLANE_SRC=/opt/invoiceplane/invoiceplane.zip

ENV IP_URL="http://localhost" \
    DB_HOSTNAME="localhost" \
    DB_USERNAME="invoiceplane" \
    DB_PASSWORD="invoiceplane" \
    DB_DATABASE="invoiceplane" \
    DB_PORT="3306"

ARG PUID=1000
ARG PGID=1000

RUN set -xe \
    && apk --no-cache update \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
        curl \
        unzip \
        php8 \
        php8-ctype \
        php8-bcmath \
        php8-dom \
        php8-gd \
        php8-mysqli \
        php8-mysqlnd \
        php8-openssl \
        php8-pdo_mysql \
        php8-fileinfo \
        php8-posix \
        php8-session \
        php8-tokenizer \
        php8-xml \
        php8-zip \
        php8-zlib \
        php8-exif \
        php8-simplexml \
        php8-xmlreader \
        php8-xmlwriter \
        php8-gmp \
    && ln -sf /usr/bin/php8 /usr/bin/php \
    && mkdir -p /opt/invoiceplane \
    && echo "InvoicePlane version: ${VERSION}" > /opt/invoiceplane/version \
    && curl -o ${INVOICEPLANE_SRC} -SL "https://github.com/InvoicePlane/InvoicePlane/releases/download/${VERSION}/${VERSION}.zip" \
    && unzip -qt ${INVOICEPLANE_SRC} \
    && rm -rf /var/cache/apk/* /tmp/*

# add local files
COPY root/ /
# ports, volumes etc from php
# ENTRYPOINT ["/init"]
