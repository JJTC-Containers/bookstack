FROM php:7.2-fpm-alpine3.7

LABEL maintainer JJTC "docker@jjtc.eu"

ENV BOOKSTACK=BookStack \
    BOOKSTACK_VERSION=0.22.0 \
    BOOKSTACK_HOME="/var/www/html/"

COPY php.ini /usr/local/etc/php/conf.d/php.ini
COPY docker-entrypoint.sh ./

# Below the following PHP extensions are installed PDO_MYSQL, ZIP, GD, Tidy, XML, Redis, Memcached, msgpack, igbinary
# PHP extensions such as DOM, OpenSSL, PDO, MBstring, Tokenizer are provided by the base image.
RUN set -ex \
  && apk update \
  && echo "Setting up PHP extensions" \
  && apk add --no-cache --virtual .build-deps \
     autoconf \
     freetype-dev \
     g++ \
     imagemagick-dev \
     libjpeg-turbo-dev \
     libmemcached-dev \
     libpng-dev \
     libwebp-dev \
     libxml2-dev \
     libzip-dev \
     make \
     openldap-dev \
     pcre-dev \
     re2c \
     tidyhtml-dev \
     zlib-dev \
  && pecl install imagick mailparse redis igbinary msgpack memcached \
  && docker-php-ext-enable imagick mailparse redis igbinary msgpack memcached \
  && pecl clear-cache \
  && docker-php-ext-configure gd \
    --with-gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-webp-dir=/usr/include/ \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install gd ldap opcache pdo_mysql zip tidy xml \
  && apk del .build-deps \
  && apk add --no-cache \
     freetype \
     imagemagick \
     libmemcached-libs \
     libressl \
     libzip \
     openldap \
     shadow \
     tar \
     tidyhtml \
     zlib \
  # todo: shadow can be removed by replacing usermod
  && usermod -u 1000 www-data \
  && chmod +x docker-entrypoint.sh \
  && echo "Instal Composer:" \
  && curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/bin/composer \
  && echo "Get BookStack:" \
  && cd ${BOOKSTACK_HOME} \
  && curl -LJO https://github.com/BookStackApp/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz \
  && tar --strip-components=1 -xzf BookStack-${BOOKSTACK_VERSION}.tar.gz \
  && rm -rf ${BOOKSTACK}-${BOOKSTACK_VERSION}.tar.gz .env.example .gitattributes .github .gitignore .travis.yml tests/ \
  && echo "Get Dependencies:" \
  && composer install \
  && echo "Changing ownership:" \
  && chown -R www-data:www-data .

WORKDIR $BOOKSTACK_HOME

EXPOSE 9000

VOLUME ["$BOOKSTACK_HOME/public/uploads", "$BOOKSTACK_HOME/public/storage"]

ENTRYPOINT ["./docker-entrypoint.sh"]
