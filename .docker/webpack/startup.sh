#!/usr/bin/env bash

USER=debian

echo "Run startup.sh ..."

echo "Host UID (startup): $USER_ID"
echo "Host GID (startup): $GROUP_ID"

# change node uid/gid
usermod -u 10000 node
groupmod -g 10000 node
find / -group 10000 -exec chgrp -h node {} \;
find / -user 10000 -exec chown -h node {} \;

echo -e "   user: ${USER} - ${USER_ID}:${USER_GID}"

# now creating user
groupadd -g "${GROUP_ID}" "${USER}"

useradd \
    --uid ${USER_ID} \
    --gid ${GROUP_ID} \
    --create-home \
    --shell /bin/bash ${USER}

awk -F: '($3 >= 1000) {printf "%s:%s\n",$1,$3}' /etc/passwd    

echo "${USER}:${USER}" | chpasswd
echo "%${USER} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
chown -R ${USER}:${USER} /root

echo "Clean folders"
rm -rf /var/www/html/bootstrap/ssr
rm -rf /var/www/html/public/build
rm -rf /var/www/html/public/hot
rm -rf /var/www/html/node_modules

echo "npm install : "
sudo -H -u ${USER} bash -c "npm install --silent"

echo "Environnement : $APP_ENV"

if [ $APP_ENV == "production" ]; then
    echo "npm build with ssr"
    sudo -H -u ${USER} bash -c "npm run build"
    sudo -H -u ${USER} bash -c "node /var/www/html/bootstrap/ssr/ssr.mjs"
else
    echo "npm run dev"
    sudo -H -u ${USER} bash -c "npm run dev"
fi