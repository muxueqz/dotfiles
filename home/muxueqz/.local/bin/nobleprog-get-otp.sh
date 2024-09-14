#!/bin/sh
OTP=$(i3-msg -t get_tree |
	jello | grep '| NobleProg User' | grep -E "title|name" | cut -d'|' -f1 | cut -d'"' -f4 | grep -o '\S*'
  )
echo $OTP
# echo $OTP | toclip
echo $OTP | wtype -

export OTP=$OTP
python3 << EOF
#!/usr/bin/env python3
from os import getenv
import dbus

obj = dbus.SessionBus().get_object("org.freedesktop.Notifications", "/org/freedesktop/Notifications")
obj = dbus.Interface(obj, "org.freedesktop.Notifications")
obj.Notify("", 0, "", "OTP Code", getenv("OTP", "None"), [], {"urgency": 1}, 10000)
EOF
