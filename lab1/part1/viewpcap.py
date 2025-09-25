#!/usr/bin/env python3

import argparse
import scapy.all as scapy


def print_pkts(pkts):
    """
    Iterates through packets in a read-in pcap file, printing them to console.
    """
    # Counter for display of packet order
    counter = 1

    # Iterate through packets
    for pkt in pkts:
        # Print packet
        print(f"PACKET {counter}".center(20,'='))
        pkt.show()

        # Iterate packet order counter
        counter += 1

def main(path):
    """
    Main function. Reads in pcap file, and runs function to print packets
    if non-empty.
    """
    # Read in pcap file from path
    pkts = scapy.rdpcap(path)

    # Make sure pcap file isn't empty
    if len(pkts) > 0:
        # Print packets
        print_pkts(pkts)
    else:
        print("Pcap file is empty!")

# Script execution
if __name__ == "__main__":
    # Handle command-line arguments
    parser = argparse.ArgumentParser(description="Reads out a pcap file to console.")
    parser.add_argument(
        "path",
        type=str,
        help="Path to pcap file to read (either relative to PWD or absolute)"
    )
    args = parser.parse_args()

    # Run script
    main(args.path)
