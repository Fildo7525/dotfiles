#!/usr/bin/env bash

OPERATION=$1
enabled_network=s=$(nmcli radio wifi)

case $OPERATION in
	toggle)
		# The compared value was checked via notify-send
		action=$([[ "$enabled_network" == "s=enabled" ]] && echo off || echo on)
		nmcli radio wifi $action
		;;
	wofi)
		chosen=$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL dev wifi list \
		  | sed 's/^*/ /' \
		  | wofi --dmenu --prompt "Wi-Fi")

		[ -z "$chosen" ] && exit

		ssid=$(echo "$chosen" | sed 's/^ //' | cut -d: -f1)

		nmcli dev wifi connect "$ssid"
		;;

	*)
		echo "No known command $0 [toggle, wofi]"
		;;
esac



