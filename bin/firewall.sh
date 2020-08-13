#!/bin/sh

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i lo -j ACCEPT 
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

iptables -A OUTPUT -p TCP --sport 32768:61000 -j ACCEPT
iptables -A OUTPUT -p UDP --sport 32768:61000 -j ACCEPT
iptables -A INPUT -p TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p UDP -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -P OUTPUT ACCEPT

# настройка локальных сервисов
iptables -A INPUT  -i venet0:0 -p TCP --dport 10022 -j ACCEPT 
iptables -A OUTPUT -o venet0:0 -p TCP --sport 10022 -j ACCEPT


iptables -A INPUT  -i venet0:0 -p TCP --dport 1194 -j ACCEPT 
iptables -A OUTPUT -o venet0:0 -p TCP --sport 1194 -j ACCEPT

iptables -A INPUT  -i venet0:0 -p TCP --dport 80 -j ACCEPT 
iptables -A OUTPUT -o venet0:0 -p TCP --sport 80 -j ACCEPT

iptables -A INPUT  -i venet0:0 -p TCP --dport 443 -j ACCEPT    
iptables -A OUTPUT -o venet0:0 -p TCP --sport 443 -j ACCEPT


#  MASQUERADE
#iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
#iptables -A FORWARD -m conntrack --ctstate NEW -i eth1 -s 10.0.0.1/24 -j ACCEPT
#iptables -P FORWARD DROP
#iptables -t nat -A POSTROUTING -o venet0:0 -j MASQUERADE

#iptables -P INPUT   ACCEPT
#iptables -P OUTPUT  ACCEPT
#iptables -P FORWARD ACCEPT












#iptables -P INPUT DROP
#iptables            -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT  для сохранения текущих подключений!!!
#iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#iptables -A INPUT -p tcp --dport 22 -j ACCEPT
