FROM php:8.0-fpm AS base

RUN apt-get update \
  && apt-get install -y \
             libfreetype6-dev \
             libjpeg62-turbo-dev \
             libmcrypt-dev \
             libpng-dev \
             zlib1g-dev \
             libxml2-dev \
             libzip-dev \
             libonig-dev \
             graphviz \
             libcurl4-openssl-dev \
             pkg-config \
             zip git nano \
             libpq-dev

RUN docker-php-ext-install pgsql \
  && docker-php-ext-install pdo_pgsql \
  && docker-php-ext-install intl \
  && docker-php-ext-install zip \
  && docker-php-ext-install mbstring \
  && docker-php-ext-install exif \
  && docker-php-ext-install opcache \
  && docker-php-ext-install bcmath \
  && docker-php-source delete

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-source delete \
  && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www
COPY --chown=www:www ./src /app
USER www

# Local env
FROM base AS local
USER root
RUN pecl install xdebug-3.0.0 \
    && docker-php-ext-enable xdebug
USER www
EXPOSE 9000
CMD ["php-fpm"]

# Production env
FROM base AS production
EXPOSE 9000
CMD ["php-fpm"]

# Worker
FROM base AS worker
# todo добавить скрипт для запуска воркеров
