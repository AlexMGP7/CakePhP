FROM php:7.4-apache

# Instalar extensiones y herramientas necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    git \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql intl

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Copiar la configuración de Apache modificada
COPY ./apache-config/000-default.conf /etc/apache2/sites-available/000-default.conf

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar archivos del proyecto
COPY . /var/www/html

# Asignar permisos a la carpeta
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Instalar dependencias de Composer
WORKDIR /var/www/html
RUN composer install

# Exponer el puerto 80
EXPOSE 80
