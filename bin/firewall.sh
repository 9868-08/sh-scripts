#!/bin/sh -x

/home/dinky/bin/firewall_open.sh

iptables -A INPUT -i lo -j ACCEPT 
iptables -A INPUT -i tun0 -j ACCEPT 


iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT

iptables -A INPUT -p TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p UDP -m state --state ESTABLISHED,RELATED -j ACCEPT


# настройка локальных сервисов
iptables -A INPUT  -i eth0 -p TCP --dport 10022 -j ACCEPT     # secured ssh
#iptables -A INPUT  -i eth0 -p TCP --dport 80 -j ACCEPT 
iptables -A INPUT  -i eth0 -p TCP --dport 8080 -j ACCEPT 
iptables -A INPUT  -i eth0 -p TCP --dport 8081 -j ACCEPT 
iptables -A INPUT  -i eth0 -p TCP --dport 443 -j ACCEPT    
iptables -A INPUT  -i eth0 -p TCP --dport 8443 -j ACCEPT    
iptables -A INPUT  -i eth0 -p TCP --dport 3000 -j ACCEPT    


#  MASQUERADE
# После выполнения этой команды, все что приходит на адрес 10.129.0.11 по 8080 порту будет передаваться на адрес 10.8.0.1:
#iptables -t nat -A PREROUTING --dst 10.129.0.11 -p tcp --dport 8080 -j DNAT --to-destination 10.8.0.1

#Однако, чтобы все работало как надо, нужно еще добавить разрешающее передачу пакетов правило, так как иначе фаирволл просто не будет пропускать соединения:
# iptables -I FORWARD 1 -i eth0 -o eth1 -d 10.8.0.1 -p tcp -m tcp --dport 8080 -j ACCEPT

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

