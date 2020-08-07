#!/usr/bin/env bash


echo "Install cron ..."
sudo cron
echo "Cron Done !"

echo "Start php-fpm"
php-fpm