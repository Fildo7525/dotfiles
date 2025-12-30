#!/usr/bin/env bash

chosen=$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL dev wifi list \
  | sed 's/^*/ /' \
  | wofi --dmenu --prompt "Wi-Fi")

[ -z "$chosen" ] && exit

ssid=$(echo "$chosen" | sed 's/^ //' | cut -d: -f1)

nmcli dev wifi connect "$ssid"

