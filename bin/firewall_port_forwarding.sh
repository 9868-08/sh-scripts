#!/bin/sh -x

#/home/dinky/bin/firewall_open.sh

# настройка локальных сервисов
iptables -A INPUT  -i eth0 -p TCP --dport 10022 -j ACCEPT     # secured ssh
iptables -A INPUT  -i eth0 -p TCP --dport 80 -j ACCEPT 


#  MASQUERADE
iptables -A FORWARD -i eth0 -o tun0 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i eth0 -o tun0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 10.8.0.1
iptables -t nat -A POSTROUTING -o tun0 -p tcp --dport 80 -d 10.8.0.1 -j SNAT --to-source 10.8.0.2

iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-FORWARD: " --log-level 4
iptables -A LOGGING -j FORWARD

#iptables -A INPUT -j DROP *

netfilter-persistent save
netfilter-persistent start

iptables-save  > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

systemctl stop    netfilter-persistent
systemctl start   netfilter-persistent
systemctl restart netfilter-persistent

