#!/bin/bash
compgen -c | sort -u -d -r | 
  grep -v "^_" | awk '{printf "%s\0icon\x1fshellscript\n", $0, $0}' | 
  fuzzel --icon-theme=gnome --dmenu | sh
