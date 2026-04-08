FROM php:7.4-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable rewrite
RUN a2enmod rewrite

# Copy project
COPY . /var/www/html/

WORKDIR /var/www/html

# 🔥 IMPORTANT: change Apache root to /web
RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/sites-available/000-default.conf

# Permissions
RUN chown -R www-data:www-data /var/www/html \
&& chmod -R 755 /var/www/html

# Fix Apache warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Allow access
RUN echo "<Directory /var/www/html/web>\n\
AllowOverride All\n\
Require all granted\n\
</Directory>" >> /etc/apache2/apache2.conf

EXPOSE 80
