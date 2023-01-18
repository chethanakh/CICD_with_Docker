FROM php:7.4-fpm-alpine

ARG UID

WORKDIR /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions end
RUN apk --update add shadow
RUN apk --update add sudo
RUN apk --update add npm
RUN docker-php-ext-install pdo_mysql

RUN addgroup -g ${UID} cicd-user && adduser -G cicd-user -g cicd-user -s /bin/sh -D cicd-user

USER cicd-user
