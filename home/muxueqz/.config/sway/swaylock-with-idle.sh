#!/bin/sh
touch /tmp/last_input_time
sudo /opt/libexec/swayidle.sh &
swaylock $@

for i in $(seq 10); do
	rm -rfv /tmp/last_input_time
	sleep 1
done

wait
