#/bin/sh

#nmap -sP 192.168.0.0/24
nmap -sP $1

#nmap -sn 192.168.2.0/24 >/dev/null ;arp -n |awk 'NR>1 && !/incomplete/ {print $1}'


