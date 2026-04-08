FROM php:7.4-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql bcmath

RUN a2enmod rewrite

COPY . /var/www/html/

WORKDIR /var/www/html

RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN echo "<Directory /var/www/html/web>\n\
AllowOverride All\n\
Require all granted\n\
</Directory>" >> /etc/apache2/apache2.conf

EXPOSE 80
