#
#
#
FROM public.ecr.aws/docker/library/php:8.2-apache-bookworm

RUN a2enmod rewrite

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    curl \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libmemcached-dev \
    zlib1g-dev \
    imagemagick

# install the PHP extensions we need
RUN docker-php-ext-install -j$(nproc) iconv \
    pdo pdo_mysql mysqli gd
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

RUN curl -J -L -s -k \
    'https://github.com/omeka/Omeka/releases/download/v3.1.1/omeka-3.1.1.zip' \
    -o /var/www/omeka.zip \
    &&  unzip -q /var/www/omeka.zip -d /var/www/ \
    &&  rm /var/www/omeka.zip \
    &&  rm -rf /var/www/html \
    &&  mv /var/www/omeka-3.1.1 /var/www/html \
    &&  chown -R www-data:www-data /var/www/html

#VOLUME /var/www/html

# Specify home
ENV APP_HOME /omeka
WORKDIR ${APP_HOME}

# .profile
COPY package/data/container_bash_profile /root/.profile

# make necessary directories
RUN mkdir -p ${APP_HOME}/scripts ${APP_HOME}/config

# port and run command
EXPOSE 80
CMD ${APP_HOME}/scripts/entry.sh

# configuration and scripts
COPY package/config/imagemagick-policy.xml /etc/ImageMagick/policy.xml
COPY package/config/.htaccess /var/www/html/.htaccess
COPY package/config/database.ini.template ${APP_HOME}/config/database.ini.template
COPY package/config/local.config.php.template ${APP_HOME}/config/local.config.php.template
COPY package/scripts/entry.sh ${APP_HOME}/scripts/entry.sh
COPY package/scripts/make-config-files.sh ${APP_HOME}/scripts/make-config-files.sh

#
# end of file
#
