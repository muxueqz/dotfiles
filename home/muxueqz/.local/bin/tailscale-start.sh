#!/bin/sh
# /opt/muxueqz-sh/tailscaled_nspawn.sh &> /dev/shm/tailscaled.log &
#export http_proxy="http://default-proxy-server:40088"
sudo firejail --noprofile --env=https_proxy=$http_proxy \
  --whitelist=/dev/null --whitelist=/dev/net/tun  --blacklist=/tmp/ --blacklist=/data/ \
  --blacklist=/home/ \
  --tmpfs=/root \
  --read-write=/var/lib/tailscale/ \
  /opt/tailscale/tailscaled &> /dev/shm/tailscaled.log &
  # --statedir /var/run/tailscale/

#sleep 3s
#/data/work/project/firejail-profiles/tailscale_nspawn.sh up
