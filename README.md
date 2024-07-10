# Next-Generation Firewall (NGFW)

This project implements a Next-Generation Firewall using open-source tools. It combines basic iptables rules with a Python-based packet inspection system using Scapy.<br>
<a href="https://github.com/MenakaGodakanda/NGFW/blob/main/Project_Description.md">Project Description</a>

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
- Basic firewall script (`basic_firewall.sh`) should configure iptables rules:
```bash
sudo ./scripts/basic_firewall.sh
```
- Expected Output:<br><br>
![Screenshot 2024-07-10 131312](https://github.com/MenakaGodakanda/NGFW/assets/156875412/259c91fe-6183-4035-af17-65bff018cffa)

- Verify the iptables rules using:
```
sudo iptables -L -v
```
![Screenshot 2024-07-10 131407](https://github.com/MenakaGodakanda/NGFW/assets/156875412/ba7684a4-93be-4507-bcfd-0c0ffa1140b1)

- The above output illustrates that the rules have been correctly applied according to the script.
    - The default policies are set correctly (`DROP` for `INPUT` and `FORWARD`, `ACCEPT` for `OUTPUT`).
    - The loopback traffic rule is working, as indicated by the packet and byte counts.
    - The established connections rule is working, as shown by the packet and byte counts.
    - The rules for SSH, HTTP, and HTTPS are in place, though no traffic has been detected yet for these services.

### 3. Running the Packet Inspection Script:
- Running the packet inspection script (`packet_inspection.py`) should capture and print IP packets:
```bash
sudo python3 ./scripts/packet_inspection.py
```

- Expected Output: This output will vary based on the network traffic at the time.<br><br>
![Screenshot 2024-07-10 131320](https://github.com/MenakaGodakanda/NGFW/assets/156875412/58771bef-4549-4a61-8a04-d17ee2d186ec)

- The above output illustrates that the rules have been correctly applied according to the script.
    - The script is functioning as intended, capturing and printing packets' source and destination IP addresses.
    - The output shows a mixture of incoming and outgoing packets, indicating active network communication involving your machine (`10.0.2.15`) and external IP addresses (`172.64.155.141` and `104.18.32.115`).
    - The packet inspection is correctly identifying and displaying IP packets.

### 4. Combine iptables and Packet Inspection
- Running the NGFW script (`ngfw.sh`) should load the iptables rules and start packet inspection:
```bash
sudo ./scripts/ngfw.sh
```
- Expected Output: Again, the exact packet details will depend on the current network traffic.<br>
![Screenshot 2024-07-10 131627](https://github.com/MenakaGodakanda/NGFW/assets/156875412/17e44412-10d5-477f-bcb3-bd59994bc047)

- The above output illustrates that the script successfully loaded the iptables rules and started packet inspection.


### 5. Running the Tests
- Running the test script (`test_firewall_rules.sh`) should verify the firewall rules and packet inspection functionality:
```bash
sudo ./tests/test_firewall_rules.sh
```
- The script will print the current iptables rules and start the packet inspection for a brief period.
- Expected Output:<br><br>
![Screenshot 2024-07-10 134845](https://github.com/MenakaGodakanda/NGFW/assets/156875412/50f4fda7-a74e-400c-98ac-823e69074d1b)

- The above output illustrates that the script successfully verified the firewall rules and packet inspection functionality.

## Troubleshooting
-  Ensure you have the necessary permissions to run scripts.
-  Verify required tools are installed.

## License

This project is licensed under the MIT License.
