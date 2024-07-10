#!/bin/bash

# Test if iptables rules are set
iptables -L -v

# Test if packet inspection script runs without errors
python3 ./scripts/packet_inspection.py &
PID=$!

# Wait and then kill the process
sleep 60
kill $PID
