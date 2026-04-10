#!/bin/bash

INT="eDP-1"
EXT="HDMI-A-1"
INT_SCALE="1.2"
EXT_DISPLAY_SETTINGS="1920x1080@75"

options="󰌢 Internal Only"
if hyprctl monitors all | grep -q "$EXT"; then
  options+="\n󰹑 Extend\n Duplicate\n󰶐 External Only"
fi

show_menu() {
  echo -e "$options" | rofi -dmenu -i -format i -theme ../themes/customMenu.rasi -p "󰍹 Display:"
}

apply_monitors() {
  hyprctl --batch "keyword monitor $INT, $1 ; keyword monitor $EXT, $2"
}

selected=$(show_menu)

if [ -z "$selected" ]; then exit; fi

case $selected in
0) # Internal Only
  apply_monitors "preferred, auto, $INT_SCALE" "disable"
  ;;
1) # Extend
  apply_monitors "preferred, 0x0, $INT_SCALE" "$EXT_DISPLAY_SETTINGS, auto-right, 1"
  ;;
2) # Duplicate
  apply_monitors "preferred, 0x0, $INT_SCALE" "$EXT_DISPLAY_SETTINGS, 0x0, 1, mirror, $INT"
  ;;
3) # External Only
  apply_monitors "disable" "$EXT_DISPLAY_SETTINGS, auto, 1"
  ;;
esac
