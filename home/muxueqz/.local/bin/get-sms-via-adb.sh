#!/bin/sh
where="'date>$(date +%s -d '30 min ago')000'"
if [ ! -z $1 ]; then
  where="$1"
fi
adb shell content query --uri content://sms/ --projection body --where ${where}
