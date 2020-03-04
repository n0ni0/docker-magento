FROM php:7.2-fpm
RUN apt-get update && apt-get install -y \
	sudo \
	git \
	bzip2 \
	cron \
	wget \
  acl \
  procps \
	libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
	libxslt-dev \
	libicu-dev \
	nano \
	vim \
    gnupg \
    && docker-php-ext-install -j$(nproc) iconv curl dom hash pdo pdo_mysql mysqli simplexml soap xsl intl zip opcache bcmath sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

#mcrypt
RUN apt-get update && apt-get install -y libmcrypt-dev \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt

# msmtp
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y msmtp

# mysql-client
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt

# Xdebug
RUN pecl install xdebug-2.6.1 \
  &&  docker-php-ext-enable xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN chmod 777 /usr/local/etc/php/conf.d/xdebug.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
RUN apt-get install -y nodejs


# Grunt
RUN npm install -g grunt-cli

# Magerun 2
RUN wget https://files.magerun.net/n98-magerun2.phar \
&& chmod +x ./n98-magerun2.phar \
&& mv ./n98-magerun2.phar /usr/local/bin/

# Pestle
RUN curl -LO http://pestle.pulsestorm.net/pestle.phar \
&& chmod +x ./pestle.phar \
&& mv ./pestle.phar /usr/local/bin/

# Oh My Zsh!
RUN sudo apt-get install -y zsh \
&& wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
&& git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k \
&& sudo apt-get -y install locales \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen \
&& rm /root/.zshrc \
&& git clone https://gist.github.com/574e9255c0e8b2256efaf540ef6f1a31.git /root/zshconfig \
&& mv /root/zshconfig/.zshrc /root/ \
&& rm -rf /root/zshconfig/ \
&& git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Mage2tv Cache Clean
RUN composer global require --dev mage2tv/magento-cache-clean \
&& export PATH="$PATH:$HOME/.composer/vendor/bin" \
&& echo '\nalias cache-clean="$HOME/.composer/vendor/bin/cache-clean.js"' >> ~/.zshrc

