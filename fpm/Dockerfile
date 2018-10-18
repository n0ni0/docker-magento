FROM php:7.1-fpm
RUN apt-get update && apt-get install -y \
sudo \
acl\
procps \
git \
bzip2 \
cron \
wget \
libfreetype6-dev \
libjpeg62-turbo-dev \
libmcrypt-dev \
libpng-dev \
libxml2-dev \
libcurl4-openssl-dev \
libxslt-dev \
libicu-dev \
nano \
vim \
gnupg \
  && docker-php-ext-install -j$(nproc) iconv mcrypt curl dom hash pdo pdo_mysql simplexml soap xsl intl zip opcache bcmath \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd

# Ssmpt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ssmtp

# mysql-client
RUN apt-get update && apt-get install -y mysql-client && rm -rf /var/lib/apt

# Install xdebug
RUN pecl install xdebug-2.6.1 \
 && docker-php-ext-enable xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN chmod 777 /usr/local/etc/php/conf.d/xdebug.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

# Grunt
RUN npm install -g grunt-cli

COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY revaliases /etc/ssmtp/revaliases
