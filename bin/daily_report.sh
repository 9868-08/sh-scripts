#!/bin/sh

token={{tocken}}
chat={{chat_id}}

echo "====  dev daily report  ====" > /tmp/report.txt
uptime >> /tmp/report.txt
/bin/df -h | /bin/grep -v overlay >> /tmp/report.txt

#echo "\n====  backup report  ====" >> /tmp/report.txt
#/home/dinky/bin/backup.sh  >> /tmp/report.txt
#sleep 30
#/usr/bin/yandex-disk status >> /tmp/report.txt


echo "\n====  mem usage report  ====" >> /tmp/report.txt
/usr/bin/free -h >> /tmp/report.txt

echo "\n====   Changed files  ====" >> /tmp/report.txt
find / -type f -mtime -1 2> /dev/null | egrep -v "proc/|sys/|var/|home/|run/|Yandex.Disk" >> /tmp/report.txt
#find / -type f -mtime -1 2> /dev/null |grep -v proc|grep -v sys|grep -v var|grep -v home|grep -v run  >> /tmp/report.txt

echo "\n====  syslog report  ====" >> /tmp/report.txt
/bin/cat /var/log/syslog |grep -va ata5|grep -v dhc|grep -v CRON|grep -v smbd|grep -v named|grep -v idmapd | grep -v bdb_equality_candidates | grep -v usb | grep -v rate-limiting|grep -v 'UFW BLOCK' |grep -v upsmon | grep -v ata5 | grep -v nmbda | grep -v pp  >> /tmp/report.txt

 
subj="====   "`date +%Y-%m-%d`"    ===="
message=`head --lines=60 /tmp/report.txt`
 
/usr/bin/curl -s --header 'Content-Type: application/json' --request 'POST' --data "{\"chat_id\":\"${chat}\",\"text\":\"${subj}\n${message}\"}" "https://api.telegram.org/bot${token}/sendMessage" > /dev/null


