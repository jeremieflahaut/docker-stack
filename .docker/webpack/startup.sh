#!/usr/bin/env bash

echo "npm install : "
npm install --silent


echo "Environnement : $APP_ENV"

if [ $APP_ENV == "production" ]; then
    npm run production
else
    npm run watch
fi