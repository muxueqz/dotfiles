#!/bin/sh
CHINA_GW=192.168.101.254

# for i in $(cat china_ip_list.txt); do sudo ip route add $i via $CHINA_GW; done
for i in $(wget -q -O - 'https://github.com/17mon/china_ip_list/raw/refs/heads/master/china_ip_list.txt'); do
	sudo ip route add $i via $CHINA_GW
done
