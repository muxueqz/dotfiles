#!/bin/bash

# TIMEOUT=180
TIMEOUT=60
# TIMEOUT=10
LAST_INPUT_TIME_FILE="/tmp/last_input_time"

get_keyboard_device() {
	for device in /dev/input/event*; do
		if udevadm info --query=all --name=$device | grep -q "ID_INPUT_KEYBOARD=1"; then
			echo $device
		fi
	done
}

turn_off_screen() {
	echo "turn off screen"
	swaymsg "output * dpms off"
}

turn_on_screen() {
	echo "turn on screen"
	swaymsg "output * dpms on"
}

monitor_keyboard() {
	while [ -e $LAST_INPUT_TIME_FILE ]; do
		if cat "$1" | head -1 >/dev/null; then
			[ -e $LAST_INPUT_TIME_FILE ] && date +%s >"$LAST_INPUT_TIME_FILE"
			turn_on_screen
		fi
		sleep 0.1
	done
}

DEVICE=$(get_keyboard_device)
touch $LAST_INPUT_TIME_FILE
turn_off_screen
for d in $DEVICE; do
	monitor_keyboard $d &
done

while [ -e $LAST_INPUT_TIME_FILE ]; do
	current_time=$(date +%s)
	last_input_time=$(cat "$LAST_INPUT_TIME_FILE")
	idle_time=$((current_time - last_input_time))

	if [ $idle_time -ge $TIMEOUT ]; then
		turn_off_screen
	fi

	sleep $(($TIMEOUT - 1))
done

kill $(jobs -p -r)
wait
