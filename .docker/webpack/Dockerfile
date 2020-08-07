FROM node:14-slim

WORKDIR /var/www/html

ARG USER_ID
ARG GROUP_ID

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f node &&\
    if getent group node ; then groupdel node; fi && \
    groupadd -g ${GROUP_ID} node && \
    useradd -l -u ${USER_ID} -g node node && \
    install -d -m 0755 -o node -g node /home/node && \
    chown --changes --silent --no-dereference --recursive \
          --from=1000:1000 ${USER_ID}:${GROUP_ID} \
        /home/node \
        /var/www/html \
    ;fi

USER node

EXPOSE 3000

COPY startup.sh /var/bin/startup.sh

CMD ["/bin/bash", "/var/bin/startup.sh"]

