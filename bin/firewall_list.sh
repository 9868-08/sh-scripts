#!/bin/sh
# https://www.cyberciti.biz/faq/how-to-list-all-iptables-rules-in-linux/

echo "===    list all IPv4 rules   ==="
iptables -S

echo
echo
echo "===    To list all tables rules   ==="
echo "iptables -L -v -n --line-numbers"

echo "===    list all rules for INPUT tables   ==="
iptables -L INPUT -v -n
echo "===    list all rules for INPUT tables   ==="
iptables -S INPUT
echo "===    list all NAT rules   ==="
iptables -t nat -nvL
