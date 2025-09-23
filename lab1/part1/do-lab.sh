#!/usr/bin/bash

# INCLUDE ALL COMMANDS NEEDED TO PERFORM THE LAB
# This file will get called from capture_submission.sh

echo "Setting up bridge"

# create tempfile with ethernet links names
# since they will be named differently each time
# (at least it is known they start with 'veth')
echo "Creating temp file for ethernet link names"
tmp=eth.txt
$sw ip -brief link | awk '{print $1}' | grep -E "^veth.*" > $tmp

# create bridge
echo "Creating brige link"
$sw sudo ip link add name lab-bridge type bridge
$sw sudo ip link set lab-bridge up

# slave ethernet links to bridge
echo "Slaving ethernet links to bridge"
while IFS="read -r eth_link"; do
  $sw ip link set $eth_link master lab-bridge
done < $tmp

# clean up tempfile
echo "Removing temp file"
rm $tmp

echo "Bridge setup done"
