#!/bin/bash

# TIMEOUT=180
TIMEOUT=${1:-60}

LAST_INPUT_TIME_FILE="/tmp/last_input_time"
LOCK_FILE=/dev/shm/sway_idle.lock

get_keyboard_device() {
	for device in /dev/input/event*; do
		if udevadm info --query=all --name=$device | grep -q "ID_INPUT_KEYBOARD=1"; then
			echo $device
		fi
	done
}

turn_off_screen() {
	echo "$(date) turn off screen"
	[[ $(swaymsg -t get_outputs | grep '"power":.*true' -c) -gt 0 ]] &&
		flock -n $LOCK_FILE -c 'swaymsg "output * dpms off"; sleep 1s' &&
		return
	echo "$(date) screen already off, so it does not need to turn off again"
}

turn_on_screen() {
	echo "$(date) turn on screen"
	flock -n $LOCK_FILE -c 'swaymsg "output * dpms on"; sleep 30s'
	echo "$(date) turn on screen unlock"
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
