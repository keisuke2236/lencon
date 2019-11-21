#!/bin/bash
service mysql start  # なぜか失敗する(調査中)
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start  # 正しく起動
mysql -u root -plencon -e 'CREATE DATABASE IF NOT EXISTS lencon2;' && \
mysql -u root -plencon -e "CREATE USER IF NOT EXISTS lencon IDENTIFIED BY 'lencon';" && \
mysql -u root -plencon -e 'GRANT ALL ON *.* TO lencon;' && \
cd /admin && tar -jxvf lencon2.dump.tar.bz2 && mysql -u root -plencon lencon2 < /admin/lencon2.dump

echo 'setup completed.'
tail -f /dev/null
