#!/bin/sh
# https://www.cyberciti.biz/faq/how-to-list-all-iptables-rules-in-linux/

echo "===    show line number ==="
echo "iptables -t nat -L --line-numbers -n"

echo "===    DELELingrule ==="
echo iptables -D INPUT 3

