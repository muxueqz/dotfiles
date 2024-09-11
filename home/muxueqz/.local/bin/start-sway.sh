#!/bin/sh
dbus-launch --sh-syntax --exit-with-session sway -c ~/.config/sway/config-$HOSTNAME
