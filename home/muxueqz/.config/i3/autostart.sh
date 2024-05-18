#!/bin/sh
#fcitx
fcitx5 -d
#clipit &

cd /data/work/project/clipmenu/
PATH=$PATH:$PWD CM_SELECTIONS='clipboard' ./clipmenud &
cd -

/home/muxueqz/workspaces/x-apps-in-container/src/app_server &> /dev/shm/x-apps-in-container.log &
/usr/lib/notification-daemon/notification-daemon &

/usr/bin/gnome-keyring-daemon --components=pkcs11,secrets --control-directory=/run/user/1000/keyring
