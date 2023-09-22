FROM woahbase/alpine-php:x86_64

LABEL maintainer="jordan@libertyware.co.uk"
LABEL version="v1.6.1-beta-3"

# Define ARG for DEFAULT_VERSION
ARG DEFAULT_VERSION="v1.6.1-beta-3"
# Define ENV for VERSION with default value set to DEFAULT_VERSION
ENV VERSION=${DEFAULT_VERSION}

ENV INVOICEPLANE_SRC=/opt/invoiceplane

ENV IP_URL="http://localhost" \
    DB_HOSTNAME="localhost" \
    DB_USERNAME="invoiceplane" \
    DB_PASSWORD="invoiceplane" \
    DB_DATABASE="invoiceplane" \
    DB_PORT="3306"

ARG PUID=1000
ARG PGID=1000

RUN set -xe \
    && apk add --no-cache --purge -uU \
        curl \
        unzip \
        php7-ctype \
        php7-bcmath \
        php7-dom \
        php7-gd \
    	php7-mysqli \
    	php7-mysqlnd \
    	php7-openssl \
    	php7-pdo_mysql \
    	php7-fileinfo \
    	php7-posix \
    	php7-session \
    	php7-tokenizer \
    	php7-xml \
    	php7-zip \
    	php7-zlib \
        php7-exif \
        php7-simplexml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-gmp \
    && mkdir -p ${INVOICEPLANE_SRC} \
    && echo "InvoicePlane version: ${VERSION}" > /opt/invoiceplane/version \
    && curl -o /tmp/invoiceplane.zip -SL "https://github.com/InvoicePlane/InvoicePlane/releases/download/${VERSION}/${VERSION}.zip" \
    && unzip /tmp/invoiceplane.zip -d /tmp \
    && mv /tmp/ip/* ${INVOICEPLANE_SRC}/ \
    && rm -rf /tmp/ip /tmp/invoiceplane.zip \
    && rm -rf /var/cache/apk/* /tmp/*

# add local files
COPY root/ /
# ports, volumes etc from php
# ENTRYPOINT ["/init"]
