#dbus-launch --sh-syntax --exit-with-session /data/work/project/qtile-env/bin/qtile &>> /tmp/qtile.log
# dbus-launch --sh-syntax --exit-with-session /data/work/project/qtile-env/bin/qtile

# dbus-launch --sh-syntax --exit-with-session $HOME/qtile-env/bin/qtile start
ln -sfv ~/.config/sway/config-$HOSTNAME /run/user/1000/sway-config-device
dbus-launch --sh-syntax --exit-with-session sway

#dbus-launch --sh-syntax --exit-with-session /usr/bin/st
#dbus-launch --sh-syntax --exit-with-x11 /data/work/project/qtile-env/bin/qtile >> /tmp/qtile.log
