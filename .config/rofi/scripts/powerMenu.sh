#!/bin/bash

show_menu() {
  options="󰍃 Logout\n Lock Screen\n Reboot\n⏻ Power Off"
  echo -e "$options" | rofi -dmenu -i -format i -theme ../themes/customMenu.rasi -p "󱐥 Power Menu:"
}

confirm_action() {
  options="Yes\nNo"
  echo -e "$options" | rofi -dmenu -i -theme ../themes/customMenu.rasi -p " $1:"
}

selected=$(show_menu)

if [ -z "$selected" ]; then exit; fi

case $selected in
0) # Logout
  command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
  ;;
1) # Lock Screen
  # hyprlock
  qs -c noctalia-shell ipc call lockScreen lock
  ;;
2) # Reboot
  confirmed=$(confirm_action "Reboot")
  [ "$confirmed" = "Yes" ] && systemctl reboot
  ;;
3) # Power Off
  confirmed=$(confirm_action "Power off")
  [ "$confirmed" = "Yes" ] && systemctl poweroff
  ;;
esac
