# Используем официальный образ PHP-FPM
FROM php:8.1-fpm

# Устанавливаем необходимые расширения
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libmariadb-dev \
    libmariadb-dev-compat \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Настраиваем Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Устанавливаем рабочую директорию
WORKDIR /var/www/html