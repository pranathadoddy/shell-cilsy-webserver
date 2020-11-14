#!/usr/bin/env bash

echo "Menyiapkan Installasi Web server"
sudo apt-get update
echo "Melakukan Installasi Webserver"
sudo apt install nginx git -y

sudo add-apt-repository universe
sudo apt install php-fpm php-mysql -y

sudo cp /vagrant/shell/default /etc/nginx/sites-enabled/default

sudo systemctl restart nginx
echo "Installasi Selesai"

echo "=============================>"
echo "Downloading Data"
echo "=============================>"

sudo rm /var/www/html/*
sudo rm -Rf /var/www/html/*
cd /var/www/html/
sudo git clone https://github.com/pranathadoddy/sosial-media-cilsy.git .

echo "=============================>"
echo "Memindahkan data"
echo "=============================>"

