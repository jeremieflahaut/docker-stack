#!/usr/bin/env bash

echo "Run startup.sh ..."

echo "Host UID (startup): $USER_ID"
echo "Host GID (startup): $GROUP_ID"

echo "Clean folders"
rm -rf /var/www/html/bootstrap/ssr
rm -rf /var/www/html/public/build
rm -rf /var/www/html/public/hot
rm -rf /var/www/html/node_modules

echo "npm install : "
npm install --silent

echo "Environment : $APP_ENV"

if [ "$APP_ENV" == "production" ]; then
    echo "npm build with ssr"
    npm run build
    node /var/www/html/bootstrap/ssr/ssr.js
else
    echo "npm run dev"
    npm run dev
fi