FROM php:7.4-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN a2enmod rewrite

# Copy project
COPY . /var/www/html/

WORKDIR /var/www/html

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Proper Apache config (IMPORTANT FIX)
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/custom.conf

RUN a2enconf custom

EXPOSE 80
