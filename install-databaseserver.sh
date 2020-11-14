#!/bin/bash

sudo apt-get update
echo "Melakukan Installasi Database Server"
#sudo apt-get install -y mysql-server

ROOT_SQL_PASS=foo123
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_SQL_PASS"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_SQL_PASS"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

mysql -u root -pfoo123 -e 'CREATE USER "newuser"@"%" IDENTIFIED BY "password";'
mysql -u root -pfoo123 -e 'GRANT ALL PRIVILEGES ON *.* TO "newuser"@"%"; FLUSH PRIVILEGES;'

grep "bind-address" /etc/mysql/mysql.conf.d/mysqld.cnf | sudo sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql

MYSQL_ROOT="newuser"
MYSQL_PASS="password"

echo "Membuat database"

mysql -u "$MYSQL_ROOT" -p"$MYSQL_PASS" -e "CREATE DATABASE dbsosmed;"

mysql -u "$MYSQL_ROOT" -p"$MYSQL_PASS" -e "USE dbsosmed; source /vagrant/database/dump.sql;"


