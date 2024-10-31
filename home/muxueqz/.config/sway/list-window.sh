#!/bin/sh
# ilia -p textlist | (
python3 $HOME/.config/sway/i3_tools.py select-window $1 |
	rofi -p "Window" -dmenu -i | (
	read -r num id name
	swaymsg "[con_id=$id]" focus
)
