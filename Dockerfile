# Dockerfile for Magento
FROM php:8.2-fpm

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    vim \
    libxml2-dev \
    zlib1g-dev \
    libxslt1-dev \
    openssl \
    default-mysql-client && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip soap intl bcmath opcache xsl sockets

# Copy pre-generated SSL Certificates
COPY certs/magento.key /etc/nginx/ssl/magento.key
COPY certs/magento.crt /etc/nginx/ssl/magento.crt

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configure Composer for resilience
RUN composer config -g process-timeout 1200 && \
    composer config -g preferred-install dist && \
    composer config -g secure-http true

# Copy custom php.ini
COPY php.ini /usr/local/etc/php/

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Set working directory
WORKDIR /var/www/html

# Set permissions
RUN usermod -u 1000 www-data && chown -R www-data:www-data /var/www/html
