FROM php:5.6-fpm

RUN apt-get update \
   && apt-get install -y \
   libfreetype6-dev \
   libjpeg62-turbo-dev \
   libpng-dev \
   libbz2-dev \
   zlib1g-dev \
   libicu-dev \
   libmcrypt-dev \
   librecode-dev \
   libxml2-dev \
   libxslt-dev \
   libzip-dev \
   git \
   g++ \
   wget \
   unzip \
   && apt-get autoremove -y \
   && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN docker-php-ext-install opcache \
   && docker-php-ext-configure gd \
   --enable-gd-native-ttf \
   --with-jpeg-dir=/usr/lib \
   --with-png-dir=/usr/lib \
   --with-freetype-dir=/usr/include/freetype2 \
   && docker-php-ext-install -j$(nproc) gd \
   && docker-php-ext-install bz2 \
   && docker-php-ext-install calendar \
   && docker-php-ext-install exif \
   && docker-php-ext-install gettext \
   && docker-php-ext-configure intl \
   && docker-php-ext-install intl \
   && docker-php-ext-install mcrypt \
   && docker-php-ext-install mysql \
   && docker-php-ext-install mysqli \
   && docker-php-ext-install pcntl \
   && docker-php-ext-install pdo_mysql \
   && docker-php-ext-install recode \
   && docker-php-ext-install shmop \
   && docker-php-ext-install soap \
   && docker-php-ext-install sockets \
   && docker-php-ext-install sysvmsg \
   && docker-php-ext-install sysvsem \
   && docker-php-ext-install sysvshm \
   && docker-php-ext-install wddx \
   && docker-php-ext-install xmlrpc \
   && docker-php-ext-install xsl \
   && docker-php-ext-install zip

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
   && sed -i '1s;^;zend_extension=/usr/local/lib/php/extensions/ioncube_loader_lin_5.6.so\n;' "$PHP_INI_DIR/php.ini"

COPY extensions/ioncube_loader_lin_5.6.so /usr/local/lib/php/extensions/ioncube_loader_lin_5.6.so
COPY custom.ini /usr/local/etc/php/conf.d/zzz.ini
