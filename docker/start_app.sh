#!/bin/bash
sudo service nginx start
sudo service mysql start
sudo chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
sudo service mysql start  # 正しく起動
sudo mysql -u root -plencon -e 'CREATE DATABASE IF NOT EXISTS lencon2;' && \
sudo mysql -u root -plencon -e "CREATE USER IF NOT EXISTS lencon IDENTIFIED BY 'lencon';" && \
sudo mysql -u root -plencon -e 'GRANT ALL ON *.* TO lencon;' && \
cd ~/data && tar -jxvf lencon2.dump.tar.bz2 && sudo mysql -u root -plencon lencon2 < ~/data/lencon2.dump

echo 'setup completed.'
tail -f /dev/null
