#!/bin/sh

pipewire &
pipewire-pulse &

cd /data/work/projects/clipmenu
./clipmenud &

swaybg -i ~/.background.jpg &
