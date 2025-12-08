#!/usr/bin/env bash

# Turn swap off
# This moves stuff in swap to the main memory and might take several minutes
sudo swapoff -a

# Create an empty swapfile
# Note that "1M" is basically just the unit and count is an integer.
# Together, they define the size. In this case 16GiB.
sudo dd if=/dev/zero of=/swapfile bs=1M count=16384

# Set the correct permissions
sudo chmod 0600 /swapfile

sudo mkswap /swapfile  # Set up a Linux swap area
sudo swapon /swapfile  # Turn the swap on
