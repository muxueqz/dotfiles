#!/bin/bash
where="'date>$(date +%s -d '30 min ago')000'"
if [ ! -z $1 ]; then
  where="$1"
fi
echo -n $(get-sms-via-adb.sh "$where"| grep -oE '[0-9]{4,6}' | head -1)
