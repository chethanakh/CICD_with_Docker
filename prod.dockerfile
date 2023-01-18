FROM php:7.4-fpm-alpine

ARG UID

WORKDIR /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk --update add shadow
RUN usermod -u $UID www-data && groupmod -g $UID www-data
RUN apk --update add sudo
RUN echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install PHP extensions end
RUN apk add --update npm
RUN docker-php-ext-install pdo_mysql

COPY ./ /var/www/html
COPY prod.env .env
RUN composer install
RUN npm install
RUN npm install -g npm@latest
RUN npm run prod
RUN chmod o+w ./storage/ -R

