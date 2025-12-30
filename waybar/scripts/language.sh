#!/usr/bin/env bash

LAYOUT=$(swaymsg -t get_inputs | jq -r '.[] | select(.name=="AT Translated Set 2 keyboard") | .xkb_active_layout_name')
case $LAYOUT in
	"English (US)")
		echo "EN"
		;;
	"Danish")
		echo "DK"
		;;
	"Slovak")
		echo "SK"
		;;
	*)
		echo "$LAYOUT"
		;;
esac

pkill -RTMIN+2 waybar
