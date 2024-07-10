# Next-Generation Firewall (NGFW)

This project implements a Next-Generation Firewall using open-source tools. It combines basic iptables rules with a Python-based packet inspection system using Scapy.

## Overview
<img width="1106" alt="Screenshot 2024-07-10 at 2 52 38 PM" src="https://github.com/MenakaGodakanda/NGFW/assets/156875412/681148f3-dd60-4115-82d8-45d8f3b5b3bd">

### Explanation
1. **Basic Firewall Script**:
    - Configures iptables rules to filter network traffic.
    - Rules specify which traffic to allow, block, or log.

2. **Packet Inspection Script**:
    - Uses Scapy to capture and inspect network packets.
    - Monitors traffic in real-time and outputs packet details.

3. **iptables**:
    - Linux kernel feature that enforces the firewall rules set by the Basic Firewall Script.
    - Filters incoming, outgoing, and forwarded packets.

4. **Scapy**:
    - Python library used in the Packet Inspection Script.
    - Captures packets that pass through iptables.
    - Analyzes packets and outputs details such as source and destination IPs.

5. **NGFW Script**:
    - Main script to orchestrate the setup and execution of the firewall.
    - Combines iptables setup and packet inspection.

6. **Test Script**:
    - Test if iptables rules are set and packet inspection works.

7. **Logs/Output**:
    - Captured packet details are logged for analysis.

8. **Test Results**:
    - Output of the Test Script.

## Set Up Environment
### Operating System
- Use a Linux distribution like Ubuntu, which is widely supported and has a large repository of open-source tools.
- This project used the `Ubuntu 22.04` Virtual Machine.

### Required Software
1. **Python**: The primary programming language for your NGFW.
```
sudo apt install python3 python3-pip
```
2. **iptables**: A user-space utility program that allows a system administrator to configure the IP packet filter rules of the Linux kernel firewall.
```
sudo apt-get install iptable
```
3. **Scapy**: A powerful Python library used for network packet manipulation.
```
sudo pip3 install scapy
```
## Usage

### 1. Clone the Repository:

Navigate to the directory where you want to store your project and clone your GitHub repository:
```
git clone https://github.com/MenakaGodakanda/NGFW.git
cd NGFW
```

### 2. Running the Basic Firewall Script:
- Basuc firewall script (`basic_firewall.sh`) should configure iptables rules:
```bash
sudo ./scripts/basic_firewall.sh
```
- Expected Output:


### 3. Running the Packet Inspection Script:
- Running the packet inspection script (`packet_inspection.py`) should capture and print IP packets:
```bash
sudo python3 ./scripts/packet_inspection.py
```

- Expected Output: This output will vary based on the network traffic at the time.


### 4. Combine iptables and Packet Inspection
- Running the NGFW script (`ngfw.sh`) should load the iptables rules and start packet inspection:
```bash
sudo ./scripts/ngfw.sh
```

- Expected Output: Again, the exact packet details will depend on the current network traffic.


### 5. Running the Tests
- Running the test script (`test_firewall_rules.sh`) should verify the firewall rules and packet inspection functionality:
```bash
sudo ./tests/test_firewall_rules.sh
```
- The script will print the current iptables rules and start the packet inspection for a brief period.
- Expected Output:

## Troubleshooting
-  Ensure you have the necessary permissions to run scripts.
-  Verify required tools are installed.

## License

This project is licensed under the MIT License.
