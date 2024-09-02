#!/bin/sh

# pipewire &
# pipewire-pulse &
fcitx5 -d
mako &

cd /data/work/projects/clipmenu
./clipmenud &
