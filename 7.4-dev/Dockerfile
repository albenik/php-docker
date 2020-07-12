FROM php:7.4-fpm-buster

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
    nginx \
    openssh-server \
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
    && rm -rf /var/lib/{apt,dpkg,cache,log} \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo 'root:iddqd' | chpasswd

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-libdir=/usr/lib \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install calendar \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install shmop \
    && docker-php-ext-install soap \
    && docker-php-ext-install sockets \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip

RUN pecl install mcrypt-1.0.3 \
    && pecl install redis-5.3.1 \
    && pecl install xdebug-2.9.6 \
    && docker-php-ext-enable mcrypt redis xdebug

COPY run.sh /root/run.sh

EXPOSE 22 80

STOPSIGNAL SIGQUIT

CMD ["/root/run.sh"]