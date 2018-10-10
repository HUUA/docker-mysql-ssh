#!/bin/bash

rm /var/run/mysqld/*
rm /var/run/crond.pid

# 修改文件目录权限
chown -R www-data:www-data /app

# Initialize empty data volume and create MySQL user
# Reference 1: https://github.com/tutumcloud/mysql/blob/master/5.5/run.sh
# Reference 2: http://stackoverflow.com/questions/20456666/bash-checking-if-folder-has-contents
if test "$(ls -A "/var/lib/mysql")"; then
    echo "=> Using an existing volume of MySQL"
else
    echo "=> Installing MySQL ..."
    mysqld --initialize-insecure || exit 1
    service mysql start
    debian_pass=`grep -m 1 password /etc/mysql/debian.cnf  | cut -d' ' -f3`
    echo "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$debian_pass'" | mysql -u root
    echo "=> Done!"
fi

service mysql start
service mysql status

mkdir /var/log/supervisor

#MYSQL need to be runned by supervisord
/usr/bin/supervisord
