FROM node:18-slim

ARG USER_ID
ARG GROUP_ID

RUN apt-get update \
   && apt-get install -y sudo git curl jq gpg libcap2-bin

RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\`` 

RUN apt-get autoremove -y && apt-get clean all

WORKDIR /var/www/html

COPY startup.sh /var/bin/startup.sh

CMD ["/bin/bash", "/var/bin/startup.sh"]

