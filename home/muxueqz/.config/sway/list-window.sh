#!/bin/sh
swaymsg -t get_tree | python3 $HOME/.config/sway/select-window.py $1 |
	ilia -p textlist | (
	read -r num id name
	swaymsg "[con_id=$id]" focus
)
