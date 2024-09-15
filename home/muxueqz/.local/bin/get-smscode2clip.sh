#!/bin/bash
for i in $(get-sms-via-adb.sh | grep -oE '[0-9]{6}'); do
	echo -n $i | toclip
	sleep 0.3s
done
