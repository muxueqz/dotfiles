#!/bin/sh

# pipewire &
# pipewire-pulse &
fcitx5 -d
mako &

cd /data/work/projects/wl-clipboard-history/
./wl-clipboard-history -t &

redshift -l 26.0960622048:119.3065881729 &
gnome-keyring-daemon --start --components=secrets

# mkdir -pv /dev/shm/temp-workspaces/;
# firejail --noprofile \
#   --whitelist=/home/muxueqz/.local/bin/rclone \
#   --whitelist=/home/muxueqz/.config/rclone/ \
  rclone mount book: /dev/shm/temp-workspaces/boxbook/ &> /dev/shm/boxbook-mount.log &
