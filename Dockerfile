# install CraftCMS
FROM composer:2 as install
WORKDIR /craft
RUN composer create-project craftcms/craft .
COPY .env .env.changes
RUN cat .env.changes >> .env

# create an Apache server with PHP 7 and extensions
FROM php:7-apache as server
RUN apt update

# install ImageMagick, zip, PDO Postgres, and certbot
RUN apt install -y imagemagick libmagickwand-dev \
                   libzip-dev zip \
                   libpq-dev \
                   python python-certbot-apache
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick
RUN docker-php-ext-configure zip --with-zip
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install zip pdo pdo_pgsql pgsql

# configure Apache
VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/etc/letsencrypt"]
COPY --from=install --chown=www-data:www-data /craft /var/www
COPY vhosts.conf /etc/apache2/sites-enabled/vhosts.conf
RUN a2enmod rewrite && a2enmod ssl && a2enmod headers
RUN . /etc/apache2/envvars && service apache2 restart

EXPOSE 80/tcp
EXPOSE 443/tcp

RUN echo "\n\
* * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\
\n\
Important!\n\
\n\
1. Open http://localhost/index.php?p=admin/install to finish setting up CraftCMS\n\
2. Run 'docker exec -it CONTAINER_ID certbot --apache' to configure SSL\n\
\n\
* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
