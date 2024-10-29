#!/bin/bash
function dep_up {
    sudo modprobe btusb 
    sudo modprobe uvcvideo
    sudo systemctl start bluetooth
}

function dep_down {
    sudo modprobe -r uvcvideo
    sudo rmmod uvcvideo
    sudo modprobe -r btusb 
    sudo rmmod btusb 
    sudo systemctl stop bluetooth
}

case "$1" in
    up )
        echo up
        dep_up
        shift ;;
    down )
        echo down
        dep_down
        shift ;;
    *)
	echo "Usage: $SCRIPTNAME {up|down}" >&2
	exit 3
	;;
esac
