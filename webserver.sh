#!/usr/bin/env bash
sudo apt-get update
sudo apt install nginx git -y
sudo add-apt-repository universe
sudo apt install php-fpm php-mysql -y

sudo rm /var/www/html/*
sudo rm -Rf /var/www/html/*
cd /var/www/html/
sudo git clone https://github.com/pranathadoddy/sosial-media-cilsy.git 

sudo cp default /etc/nginx/sites-enabled/default

sudo systemctl restart nginx

sudo apt-get update

ROOT_SQL_PASS=foo123
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_SQL_PASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_SQL_PASS"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

mysql -u root -pfoo123 -e 'CREATE USER "newuser"@"%" IDENTIFIED BY "password";'
mysql -u root -pfoo123 -e 'GRANT ALL PRIVILEGES ON *.* TO "newuser"@"%"; FLUSH PRIVILEGES;'

sudo systemctl restart mysql

MYSQL_ROOT="newuser"
MYSQL_PASS="password"

mysql -u "$MYSQL_ROOT" -p"$MYSQL_PASS" -e "CREATE DATABASE dbsosmed;"

mysql -u "$MYSQL_ROOT" -p"$MYSQL_PASS" -e "USE dbsosmed; source /var/www/html/dump.sql;"
