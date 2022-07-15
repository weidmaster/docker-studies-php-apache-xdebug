FROM php:8.1-apache

LABEL maintainer="Eduardo WB"

COPY .docker/php/php.ini /usr/local/etc/php/
COPY . /srv/app
COPY .docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN docker-php-ext-install pdo_mysql opcache \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && a2enmod rewrite negotiation

COPY .docker/php/xdebug-dev.ini /usr/local/etc/php/conf.d/xdebug-dev.ini

RUN chown -R www-data:www-data /srv/app
