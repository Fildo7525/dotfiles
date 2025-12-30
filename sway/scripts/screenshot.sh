#!/usr/bin/env bash

AREA="$1"
if [ -z "$AREA" ]; then
	AREA="full"
fi

out="$HOME/Pictures/Screenshots/screenshot-$(date '+%Y-%m-%d_%H-%M-%S').png"

case "$AREA" in
	full)
		grim - | tee "${out}" | wl-copy -t image/png
		;;
	region)
		GEOM="$(slurp)"
		[ -z "$GEOM" ] && exit 0

		grim -g "${GEOM}" - | tee ${out} | wl-copy -t image/png
		;;
	*)
		notify-send "Usage: $0 [full|region]"
		exit 1
		;;
esac

ACTION="$(notify-send "Screenshot saved" "$(basename "$out")" \
	--action=open="Open image" \
	--action=show="Show folder" \
	--hint=boolean:transient:false \
	--expire-time=60000)"

case "$ACTION" in
	open)
		xdg-open "$out"
		;;
	show)
		xdg-open "$(dirname "$out")"
		;;
esac

