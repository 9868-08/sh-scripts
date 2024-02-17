#!/bin/sh

IPT="/sbin/iptables"

IF_EXT="eth0" # Внешний сетевой адаптер
IF_INT="tun0" # Внутренний сетевой адаптер

IP_EXT="10.129.0.11" # Внешний IP
IP_INT="10.8.0.2" # Внутренний IP

FAKE_PORT="8080" # Фейковый порт, доступен из интернет

LOCAL_SRV="10.8.0.1" # Web сервер в LAN
SRV_PORT="443" # Настоящий порт

# NAT
$IPT -t nat -A PREROUTING -i $IF_EXT -p tcp -d $IP_EXT --dport $FAKE_PORT -j DNAT --to $LOCAL_SRV:$SRV_PORT

# FORWARD
$IPT -A FORWARD -i $IF_EXT -o $IF_INT -d $LOCAL_SRV -p tcp --dport $SRV_PORT -j ACCEPT
