FROM php:8.1-fpm

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip

COPY --from=composer:2.5.5 /usr/bin/composer /usr/bin/composer

COPY ./composer.* ./

RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

COPY . .

RUN chown -R www-data:www-data /var/www/html/var/log

USER www-data
