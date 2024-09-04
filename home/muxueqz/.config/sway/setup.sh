#!/bin/sh
rsync -av --progress ./swayidle.sh ./swaylock-with-idle.sh /opt/libexec/
sudo chown root:root /opt/libexec/swayidle.sh /opt/libexec/swaylock-with-idle.sh
sudo chmod 755 /opt/libexec/swayidle.sh /opt/libexec/swaylock-with-idle.sh
