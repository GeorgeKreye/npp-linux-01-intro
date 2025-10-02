#!/usr/bin/bash

# INCLUDE ALL COMMANDS NEEDED TO PERFORM THE LAB
# This file will get called from capture_submission.sh

# Load aliases
echo "Loading aliases"
shopt -s expand_aliases
source ./provided/make_aliases.sh

echo "Setting up bridge"

# get ethernet links
sw ip link show
INTERFACES_RAW=$( sw ip -o link show | awk -F: '{print $2}' | grep -v lo | grep -E 'eth' )
touch tmp.txt # used for cropping @* section
for interface in $INTERFACES_RAW; do
  echo "${interface%%@*}" >> tmp.txt
done
INTERFACES=$( cat tmp.txt )
rm tmp.txt
echo $INTERFACES

# create bridge
echo "Creating brige link"
sw ip link add name lab-bridge type bridge

# slave ethernet links to bridge
echo "Slaving ethernet links to bridge"
for interface in $INTERFACES; do
  sw ip link set $interface down
  sw ip link set $interface master lab-bridge
done
  

# bring everything up
echo "Bringing bridge up"
sw ip link set lab-bridge up
for interface in $INTERFACES; do
  sw ip link set $interface up
done

echo "Bridge setup done"
