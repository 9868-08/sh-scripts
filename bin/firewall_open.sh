#!/bin/sh

iptables -F
#iptables -F -t nat
#iptables -F -t mangle
#iptables -X
#iptables -t nat -X
#iptables -t mangle -X

#iptables -A INPUT -i lo -j ACCEPT 
#iptables -A INPUT -i tun0 -j ACCEPT 
iptables -A INPUT -i eth0 -j ACCEPT 


#netfilter-persistent save
#netfilter-persistent start

#iptables-save  > /etc/iptables/rules.v4
#ip6tables-save > /etc/iptables/rules.v6

systemctl stop    netfilter-persistent
systemctl start   netfilter-persistent
systemctl restart netfilter-persistent

