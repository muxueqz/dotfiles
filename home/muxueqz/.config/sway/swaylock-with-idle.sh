#!/bin/sh
touch /tmp/last_input_time
# if time is between 22:00 to 09:00, timeout is 10s
timeout=3600
if test $(date +%H) -gt 22 -o $(date +%H) -lt 9; then
  timeout=10
fi
sudo /opt/libexec/swayidle.sh &
swaylock $@

for i in $(seq 10); do
	rm -rfv /tmp/last_input_time
	sleep 1
done

wait
