#!/bin/sh
# ilia -p textlist | (
swaymsg -t get_tree | python3 $HOME/.config/sway/select-window.py $1 |
	rofi -p "Window" -dmenu -i | (
	read -r num id name
	swaymsg "[con_id=$id]" focus
)
