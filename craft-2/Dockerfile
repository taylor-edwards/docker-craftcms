FROM php:7-apache as server

# install ImageMagick, zip, mcrypt, oniguruma, PDO MySQL, and certbot
RUN apt update
RUN apt install -y imagemagick libmagickwand-dev \
                   libzip-dev zip libpq-dev libonig-dev libmcrypt-dev \
                   python python-certbot-apache
RUN printf "\n" | pecl install imagick mcrypt
RUN docker-php-ext-enable imagick mcrypt
RUN docker-php-ext-configure zip --with-zip
RUN docker-php-ext-install zip pdo pdo_mysql mbstring

# configure Apache
VOLUME ["/var/www", "/etc/apache2/sites-enabled", "/etc/letsencrypt"]
RUN a2enmod rewrite && a2enmod ssl && a2enmod headers
RUN . /etc/apache2/envvars && service apache2 restart

EXPOSE 80/tcp
EXPOSE 443/tcp
