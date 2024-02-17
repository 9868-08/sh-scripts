#/bin/sh

/usr/bin/mysqld_multi start 1
/usr/bin/mysqld_multi start 2
sleep 5
ps ax|grep mysql > /var/log/multy.log
/usr/bin/mysqld_multi report >> /var/log/multy.log


