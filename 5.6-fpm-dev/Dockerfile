FROM php:5.6-fpm-stretch

RUN apt-get update \
   && apt-get dist-upgrade -y \
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
   g++ \
   git \
   wget \
   unzip \
   && apt-get autoremove -y \
   && apt-get autoclean -y \
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

RUN BEFORE_PWD=$(pwd) \
   && mkdir -p /opt/xdebug \
   && cd /opt/xdebug \
   && curl -k -L https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_5.tar.gz | tar zx \
   && cd xdebug-XDEBUG_2_5_5 \
   && phpize \
   && ./configure --enable-xdebug \
   && make clean \
   && sed -i 's/-O2/-O0/g' Makefile \
   && make \
   && make install \
   && cd "${BEFORE_PWD}" \
   && rm -r /opt/xdebug

COPY extensions/ioncube_loader_lin_5.6.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/ioncube_loader_lin_5.6.so

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" \ 
   && echo "\nopcache.enable = On" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
   && echo "zend_extension = xdebug.so" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
   && echo "xdebug.remote_enable = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
   && echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
   && sed -i '1s;^;zend_extension = ioncube_loader_lin_5.6.so\n;' "$PHP_INI_DIR/php.ini" \
   && sed -i 's;^memory_limit.*$;memory_limit = 512M\n;' "$PHP_INI_DIR/php.ini"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 2.0.8

RUN set -eux; \
  curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer; \
  php -r " \
    \$signature = '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'; \
    \$hash = hash('sha384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
      unlink('/tmp/installer.php'); \
      echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
      exit(1); \
    }"; \
  php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}; \
  composer --ansi --version --no-interaction; \
  rm -f /tmp/installer.php; \
  find /tmp -type d -exec chmod -v 1777 {} +

WORKDIR /app