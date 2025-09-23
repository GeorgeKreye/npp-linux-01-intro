#!/usr/bin/env python3

from scapy.all import *


def print_pkts(pkts):
    counter = 0
    for pkt in pkts:
        print(f"=PACKET {counter}").center(10,'=')
        counter += 1

def main():
    path = input("Enter pcap filepath (either relative from PWD or absolute):\n")
    pkts = rdpcap(path)
    if len(pkts) > 0:
        print_pkts(pkts)
    else:
        print("Pcap file is empty!")

if __name__ == "__main__":
    main()
