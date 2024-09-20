#!/bin/bash

re="^[0-9]+$"

# Check if the user is root and if a second argument was provided (the size of the swapfile)
if [ "$EUID" -ne 0 ] || [ -z "$1" ] || ! [[ $yournumber =~ $re ]]; then
	echo "Please run as root and provide the size of the swapfile in MiB as an argument."
	echo "extendSwap.sh <size in MiB>"
	echo "Example to extend swap to 8GiB: extendSwap.sh 8192"
	exit
fi

count=$1

# Turn swap off
# This moves stuff in swap to the main memory and might take several minutes
sudo swapoff -a

# Create an empty swapfile
# Note that "1M" is basically just the unit and count is an integer.
# Together, they define the size. In the example case 8GiB.
sudo dd if=/dev/zero of=/swapfile bs=1M count=$count

# Set the correct permissions
sudo chmod 0600 /swapfile

sudo mkswap /swapfile  # Set up a Linux swap area
sudo swapon /swapfile  # Turn the swap on
