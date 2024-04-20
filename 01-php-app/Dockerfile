FROM alpine:latest

WORKDIR /var/www/html/

# Essentials
RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache zip unzip curl sqlite nginx supervisor

# Installing bash
RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing PHP
RUN apk add --no-cache php82 \
    php82-common \
    php82-fpm \
    php82-pdo \
    php82-opcache \
    php82-zip \
    php82-phar \
    php82-iconv \
    php82-cli \
    php82-curl \
    php82-openssl \
    php82-mbstring \
    php82-tokenizer \
    php82-fileinfo \
    php82-json \
    php82-xml \
    php82-xmlwriter \
    php82-simplexml \
    php82-dom \
    php82-pdo_mysql \
    php82-pdo_sqlite \
    php82-tokenizer \
    php82-pecl-redis

RUN rm -rf /usr/bin/php
RUN ln -s /usr/bin/php82 /usr/bin/php

# Configure supervisor
RUN mkdir -p /etc/supervisor.d/
COPY docker/supervisord.ini /etc/supervisor.d/supervisord.ini

# store PID of the php fpm
RUN mkdir -p /run/php/
RUN touch /run/php/php8.2-fpm.pid

# php fpm configuration
COPY docker/php-fpm.conf /etc/php82/php-fpm.conf

# Configure nginx
COPY docker/nginx.conf /etc/nginx/
COPY docker/svc.conf /etc/nginx/modules/

# store PID of the nginx
RUN mkdir -p /run/nginx/
RUN touch /run/nginx/nginx.pid

# linking stdout & stderr as access&error log
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Building process
COPY src/ /var/www/html/public
RUN chown -R nobody:nobody /var/www/html/public

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]