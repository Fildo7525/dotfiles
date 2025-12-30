#!/usr/bin/env bash

# Device to control either sink or source.
DEVICE=$1
DEVICE_UPPER=$(echo "$DEVICE" | tr '[:lower:]' '[:upper:]')

# Once of the operations: up, down, toggle.
OPERATION=$2

# Define maximum volume level. This value was read from the max value from pavucontrol.
MAX_VOLUME=153

if [ -z "$DEVICE" ] || [ -z "$OPERATION" ]; then
	echo "Usage: $0 sink|source up|down|toggle [step:=5]"
	exit 1
fi


case $DEVICE in
	sink)
		STEP=$([[ -z $3 ]] && echo 5 || echo $3)
		;;
	source)
		STEP=$([[ -z $3 ]] && echo 5 || echo $3)
		;;
	*)
		echo "First argument must be 'sink' or 'source'"
		echo "Usage: $0 sink|source up|down|toggle [step:=5]"
		exit 1
		;;
esac

# Works only if left and right channels are equal
let current_volume=$(pactl get-$DEVICE-volume @DEFAULT_$DEVICE_UPPER@ | grep -Po '\d+(?=%)' | head -n 1)


case $OPERATION in
	toggle)
		echo "pactl set-$DEVICE-mute @DEFAULT_$DEVICE_UPPER@ toggle"
		pactl set-$DEVICE-mute @DEFAULT_$DEVICE_UPPER@ toggle
		;;
	up)
		if [[ $( expr $current_volume + $STEP ) -gt $MAX_VOLUME ]]; then
			echo "Max volume reached"
			pactl set-$DEVICE-volume @DEFAULT_$DEVICE_UPPER@ $MAX_VOLUME%
			exit 0
		fi
		echo "Increasing volume"
		pactl set-$DEVICE-volume @DEFAULT_$DEVICE_UPPER@ +$STEP%
		;;
	down)
		if [[ $current_volume -eq $MAX_VOLUME && $# -eq 2 ]]; then
			pactl set-$DEVICE-volume @DEFAULT_$DEVICE_UPPER@ 150%
			exit 0
		fi
		pactl set-$DEVICE-volume @DEFAULT_$DEVICE_UPPER@ -$STEP%
		;;
	*)
		echo "Usage: $0 sink|source up|down|toggle [step]"
		exit 1
		;;
esac

