#!/bin/sh

token='5376188347:AAEd7rbmAl4aeeLgSkRwGtgMCO48qf7b6uI'
chat="418832166"

rm -f /tmp/report.txt
#echo "====   `date +%Y-%m-%d`    ====" >> /tmp/report.txt
echo "====  dev daily report  ====" >> /tmp/report.txt
uptime >> /tmp/report.txt

subj="====   "`date +"%D %T"`"    ===="

message=`echo $1 |head --lines=60`
# /usr/bin/curl -s --header 'Content-Type: application/json' --request 'POST' --data "{\"chat_id\":\"${chat}\",\"text\":\"${subj}\n${message}\"}" "https://api.telegram.org/bot${token}/sendMessage" > /dev/null

/usr/bin/curl -s --header 'Content-Type: application/json' --request 'POST' --data "{\"chat_id\":\"${chat}\",\"text\":\"${subj}\n${message}\"}" "https://api.telegram.org/bot${token}/sendMessage" > /dev/null

