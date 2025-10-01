#!/usr/bin/bash

# INCLUDE ALL COMMANDS NEEDED TO PERFORM THE LAB
# This file will get called from capture_submission.sh

echo "Setting up bridge"

# get ethernet links
INTERFACES=$($sw ip -o link show | awk -F: '{print $2}' | grep -v lo | grep -E 'veth')
echo $INTERFACES

# create bridge
echo "Creating brige link"
$sw sudo ip link add name lab-bridge type bridge

# slave ethernet links to bridge
echo "Slaving ethernet links to bridge"
for interface in $INTERFACES; do
  ip link set $interface down
  ip link set $interface master lab-bridge
done
  

# bring everything up
echo "Bringing bridge up"
$sw sudo ip link set lab-bridge up
for interface in $INTERFACES; do
  ip link set $interface up
done

echo "Bridge setup done"

