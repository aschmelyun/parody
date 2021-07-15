FROM alpine:latest

LABEL maintainer="Andrew Schmelyun <me@aschmelyun.com>"

RUN apk update && apk add --no-cache \
    curl \
    git \
    zip \
    unzip \
    gnupg \
    bash \
    supervisor \
    mysql \
    mysql-client \
    php7 \
    php7-common \
    php7-zip \
    php7-iconv \
    php7-curl \
    php7-tokenizer \
    php7-fileinfo \
    php7-json \
    php7-mbstring \
    php7-phar \
    php7-xml \
    php7-xmlwriter \
    php7-simplexml \
    php7-dom \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-session \
    openssl \
    php7-openssl && \
    rm -rf /var/cache/apk/*

RUN php --version && php --ini

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db

RUN composer create-project laravel/laravel .

RUN composer require tymon/jwt-auth

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN chown laravel:laravel /var/www/html

VOLUME /var/www/html

STOPSIGNAL SIGINT

EXPOSE 80

ADD ./supervisord.conf /etc/supervisord.conf

ADD ./parody.sh /var/www/html/parody.sh

RUN chmod +x /var/www/html/parody.sh

ENTRYPOINT ["/bin/sh", "/var/www/html/parody.sh"]
