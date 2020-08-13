#!/bin/sh

filename=`date +%Y-%m-%d`
filenameold=`date +%Y-%m-%d --date="1 days ago"`
old_file=`date -d "-10 days" "+%Y-%m-%d"`
pass=`pwgen -N 1 -v`
echo '!archive password!'
echo pass=$pass

/usr/bin/mysqldump -u root --password=$mysql_passwd --all-databases --events --ignore-table=mysql.event --port=3306  > /home/dinky/smart/$filename.sql 
/usr/bin/mysqldump -u root --password=$mysql_passwd --all-databases --events --ignore-table=mysql.event --port=13306  > /home/dinky/smart/$filename-local.sql 

cd /home/dinky/smart/
/usr/bin/zip -P $pass /root/Yandex.Disk/$filename.zip *.sql 

/bin/rm  /home/dinky/smart/*.sql

find /root/Yandex.Disk/  -mindepth 1 -mtime +7 -name *.zip -delete
#ls -la /root/Yandex.Disk
/usr/bin/yandex-disk status



