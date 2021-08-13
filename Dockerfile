FROM php:7.3-cli

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt update && apt install -y wget git zip

RUN apt install -y libzip-dev libonig-dev libxml2-dev libssh2-1-dev libpng-dev

RUN curl http://pecl.php.net/get/ssh2-1.2.tgz -o ssh2.tgz && \
    pecl install ssh2 ssh2.tgz && \
    docker-php-ext-enable ssh2 && \
    rm -rf ssh2.tgz

RUN docker-php-ext-install zip ctype fileinfo json mbstring pdo tokenizer xml pdo_mysql gd

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get install -y nodejs

RUN chmod -R 755 /root/

RUN composer global require laravel/installer

ENV PATH=${PATH}:/root/.composer/vendor/bin

RUN mkdir -p /home/

RUN chmod 777 /home/

ENV HOME=/home/

RUN echo "PS1='laravel-vue:\w\$ '" >> /etc/bash.bashrc

RUN mkdir -p /laravue-app

WORKDIR /laravue-app

