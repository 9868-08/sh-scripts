#!/bin/sh +x
# Правила необходимые для отладки. Что бы не загромождать лог лишними пакетами логировать будем только тот трафик что относиться к IPsec туннелю, для этого четко пропишем, что нас интересует только трафик с IP 10.8.0.1который является сервером

iptables -I INPUT 1 -m limit --limit 5/m -j LOG --log-prefix="iptables: all packets" --log-level 4

