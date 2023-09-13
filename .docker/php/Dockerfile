FROM jflahaut/php-fpm

ARG USER_ID
ARG GROUP_ID

RUN apt-get update \ 
    && apt-get upgrade -y \ 
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean all

RUN usermod -u $USER_ID www-data && groupmod -g $GROUP_ID www-data
RUN chown -R www-data:www-data /var/www

COPY custom-php.ini /usr/local/etc/php/conf.d/

COPY ./crons/laravel /etc/cron.d/laravel
RUN chmod 0644 /etc/cron.d/laravel

USER www-data

RUN crontab /etc/cron.d/laravel

ENV PATH="/var/www/.composer/vendor/bin:${PATH}"
RUN composer global require laravel/installer
