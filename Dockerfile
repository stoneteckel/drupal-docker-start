# Utiliser l'image PHP avec Apache
FROM php:8.1-apache

# Installer les extensions PHP nécessaires pour Drupal
RUN apt update && apt upgrade -y \
    && apt install -y software-properties-common

RUN apt install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    vim \
    curl \
    ca-certificates \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd opcache zip mysqli pdo pdo_mysql

# Activer le module Apache rewrite (indispensable pour Drupal)
RUN a2enmod rewrite ssl
RUN mkdir -p /var/www/html/web/sites/default/files/translations
RUN chown -R www-data:www-data /var/www/html/web/sites/default/files

# Configurer PHP pour une utilisation en développement
COPY ./app/php.ini.dev /usr/local/etc/php/php.ini
COPY ./ssl/certs/destroyer.crt /etc/ssl/certs/
COPY ./ssl/private/destroyer.key /etc/ssl/private/
RUN  chown -R www-data:www-data /etc/ssl/private
COPY ./app/site.conf /etc/apache2/sites-available/
COPY ./composer.phar /usr/local/bin/composer

RUN a2ensite site.conf

# Définir le dossier de travail
WORKDIR /var/www/html

# Utiliser un utilisateur non root pour plus de sécurité
USER www-data
