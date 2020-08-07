FROM jflahaut/php-fpm:latest

ARG USER_ID
ARG GROUP_ID

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f www-data &&\
    if getent group www-data ; then groupdel www-data; fi && \
    groupadd -g ${GROUP_ID} www-data && \
    useradd -l -u ${USER_ID} -g www-data www-data && \
    install -d -m 0755 -o www-data -g www-data /home/www-data && \
    chown --changes --silent --no-dereference --recursive \
          --from=33:33 ${USER_ID}:${GROUP_ID} \
        /home/www-data \
        /var/www/html \
    ;fi

ADD cron /etc/cron.d/cron
RUN chmod 0644 /etc/cron.d/cron && crontab /etc/cron.d/cron && touch /var/log/cron.log
RUN echo "%www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


USER www-data

COPY startup.sh /var/bin/startup.sh

CMD ["/bin/bash", "/var/bin/startup.sh"]
