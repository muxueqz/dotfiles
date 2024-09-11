#!/bin/sh

# pipewire &
# pipewire-pulse &
fcitx5 -d
mako &

cd /data/work/projects/clipmenu
./clipmenud &

redshift -l 26.0960622048:119.3065881729 &
gnome-keyring-daemon --start --components=secrets
