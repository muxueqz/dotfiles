#!/bin/sh
OTP=$(i3-msg -t get_tree |
	jello | grep '| NobleProg User' | grep -E "title|name" | cut -d'|' -f1 | cut -d'"' -f4 | grep -o '\S*'
  )
echo $OTP
# echo $OTP | toclip
echo $OTP | wtype -

export OTP=$OTP
notify-send -t 10000 "OTP code" $OTP
