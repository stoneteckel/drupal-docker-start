# Utiliser l'image PHP avec Apache
FROM php:8.3-apache

# Installer les extensions PHP nécessaires pour Drupal
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    vim \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd opcache mysqli zip

# Activer le module Apache rewrite (indispensable pour Drupal)
RUN a2enmod rewrite ssl

# Variables
ENV VIRTUAL_HOST=example.com

# Configurer PHP pour une utilisation en développement
COPY ./app/php.ini /usr/local/etc/php/
COPY ./app/site.conf /etc/apache2/sites-available/

RUN a2ensite site.conf

# Définir le dossier de travail
WORKDIR /var/www/html

# Changer les permissions du dossier pour permettre au serveur web de l'écrire
RUN chown -R www-data:www-data /var/www/html

# Utiliser un utilisateur non root pour plus de sécurité
USER www-data
