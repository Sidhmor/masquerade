FROM php:8.1-cli
WORKDIR /home/app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libpq-dev \
    libpng-dev \
    libicu-dev
RUN docker-php-ext-install zip pdo pdo_pgsql pdo_mysql intl exif
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN apt-get update && apt-get install -y mariadb-client