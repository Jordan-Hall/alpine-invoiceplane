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
    && apk add --no-cache --purge -uU \
        curl \
        unzip \
        php-ctype \
        php-bcmath \
        php-dom \
        php-gd \
    	php-mysqli \
    	php-mysqlnd \
    	php-openssl \
    	php-pdo_mysql \
    	php-fileinfo \
    	php-posix \
    	php-session \
    	php-tokenizer \
    	php-xml \
    	php-zip \
    	php-zlib \
        php-exif \
        php-simplexml \
        php-xmlreader \
        php-xmlwriter \
        php-gmp \
    && mkdir -p /opt/invoiceplane \
    && echo "InvoicePlane version: ${VERSION}" > /opt/invoiceplane/version \
    && curl -o ${INVOICEPLANE_SRC} -SL "https://github.com/InvoicePlane/InvoicePlane/releases/download/${VERSION}/${VERSION}.zip" \
    && unzip -qt ${INVOICEPLANE_SRC} \
    && rm -rf /var/cache/apk/* /tmp/*

# add local files
COPY root/ /
# ports, volumes etc from php
# ENTRYPOINT ["/init"]
