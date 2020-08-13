#!/bin/sh


#echo "\n==================================  TalAnt web server daily report  ================================="
#uptime

echo ""
/bin/df -h

echo "\n------------------------------------  backup report  ------------------------------------------------"
cat /home/dinky/smart/backup_report.log 


echo "\n----------------------------------  mem usage report  -----------------------------------------------"
free

echo "\n------------------------------------  syslog report  ------------------------------------------------"
/bin/cat /var/log/syslog |grep -va ata5|grep -v dhc|grep -v CRON|grep -v smbd|grep -v named|grep -v idmapd | grep -v bdb_equality_candidates | grep -v usb | grep -v rate-limiting|grep -v 'UFW BLOCK' |grep -v upsmon | grep -v ata5 | grep -v nmbda | grep -v pp
#/bin/cat /var/log/syslog.1 |grep -v ata5|grep -v dhc|grep -v CRON|grep -v smbd|grep -v named |grep -v idmapd | grep -v bdb_equality_candidates | grep -v usb | grep -v rate-limiting|grep -v 'UFW BLOCK'| grep -v upsmon | grep -v ata5 | grep -v nmbd

#rm /root/report.txt
#wget ftp://10.8.0.6/report.txt 2> /dev/null
#cat /root/report.txt

echo "\n------------------------------------  Changed files  ------------------------------------------------"
find / -type f -mtime -1 2> /dev/null | egrep -v "proc/|sys/|var/|home/|run/|Yandex.Disk"
#find / -type f -mtime -1 2> /dev/null |grep -v proc|grep -v sys|grep -v var|grep -v home|grep -v run 




