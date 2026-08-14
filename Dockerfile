# Su dung phien ban PHP moi nhat voi Apache
FROM php:apache

# Cai dat cac extension PHP can thiet
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Copy source code vao web root cua Apache
COPY src/ /var/www/html/

# Phan quyen cho thu muc web
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Bat mod rewrite
RUN a2enmod rewrite

# Expose port 80 cua container
EXPOSE 80

# Chay Apache o foreground
CMD ["apache2-foreground"]
