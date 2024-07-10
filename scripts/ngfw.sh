#!/bin/bash

# Load basic firewall rules
sudo ./scripts/basic_firewall.sh

# Run packet inspection
sudo python3 ./scripts/packet_inspection.py
