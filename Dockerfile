# install CraftCMS
FROM composer:2 as install
WORKDIR /craft
RUN composer create-project craftcms/craft .

# create an Apache server with PHP 7 and extensions
FROM php:7-apache as server
RUN apt update

# configure apache
RUN a2enmod rewrite
RUN . /etc/apache2/envvars && service apache2 restart

# install ImageMagick
RUN apt install -y imagemagick libmagickwand-dev
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick

# install zip
RUN apt install -y libzip-dev zip
RUN docker-php-ext-configure zip --with-zip
RUN docker-php-ext-install zip

# install PDO Postgres
RUN apt install -y libpq-dev
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo pdo_pgsql pgsql

# copy Craft installation and site files
COPY --from=install --chown=www-data:www-data /craft /var/www
COPY ./.env /var/www/.env.changes
RUN cat /var/www/.env.changes >> /var/www/.env
RUN rm -rf /var/www/html && mv /var/www/web /var/www/html

EXPOSE 80/tcp
EXPOSE 443/tcp

# set up and start craft
RUN echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\
Open http://localhost/index.php?p=admin/install to finish setting up CraftCMS\n\
* * * * * * * * * * * * * * * * * * * * * * * * * * * *"
