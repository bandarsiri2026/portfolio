# PHP 7.4 for the legacy Laravel 5.x projects.
# On Apple Silicon use the amd64 image: the arm64 php:7.4 build hangs under Docker 29.
FROM --platform=linux/amd64 php:7.4
# Debian bullseye is EOL, so apt must point at the archive mirror.
RUN sed -i 's|http://deb.debian.org/debian-security|http://archive.debian.org/debian-security|' /etc/apt/sources.list \
 && apt-get update -qq \
 && apt-get install -y --no-install-recommends libonig-dev unzip git
RUN docker-php-ext-install pdo_mysql mbstring
# Composer 1.10: Laravel <=6 reads the old installed.json format and breaks on Composer 2.
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.13 --install-dir=/usr/local/bin --filename=composer
WORKDIR /app
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
