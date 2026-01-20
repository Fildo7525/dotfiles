#!/usr/bin/env bash

powered=$(bluetoothctl show | grep Power | awk '{print $2}')

operation=$1

case $operation in
	"toggle")
		if [ "$powered" = "yes" ]; then
			bluetoothctl power off
		else
			bluetoothctl power on
		fi
		;;
	*)
		exit 0
		;;
esac
