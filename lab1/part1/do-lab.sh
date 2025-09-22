#!/usr/bin/bash

# INCLUDE ALL COMMANDS NEEDED TO PERFORM THE LAB
# This file will get called from capture_submission.sh

# create bridge
sw ip link add name lab-bridge type bridge
sw ip link set lab-bridge up

# slave hosts to bridge
sw ip link set eth1 master lab-bridge
sw ip link set eth2 master lab-bridge
sw ip link set eth3 master lab-bridge
sw ip link set eth4 master lab-bridge
