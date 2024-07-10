# Next-Generation Firewall (NGFW) - Version 1

This project implements a Next-Generation Firewall using open-source tools. It combines basic iptables rules with a Python-based packet inspection system using Scapy.

## Features

### 1. Basic Firewall Configuration:
- Configures essential firewall rules using iptables, including setting default policies to drop unsolicited traffic, allowing loopback and established connections, and permitting specific ports (SSH, HTTP, HTTPS) to secure the network by controlling incoming and outgoing traffic.

### 2. Real-Time Packet Inspection:
- Utilizes Scapy, a Python-based packet analysis tool, to capture and log network packets in real-time, providing detailed visibility into network traffic by printing the source and destination IP addresses of each packet.

### 3. Combined Firewall and Packet Inspection:
- Integrates basic firewall rules with real-time packet inspection into a cohesive system, ensuring both proactive traffic filtering and reactive traffic monitoring, enhancing overall network security through layered protection.

### 4. Testing and Verification:
- Implements a test script to verify the correct application of firewall rules and the functionality of the packet inspection script. It lists current iptables rules and runs the packet inspection for a set period, ensuring both components work as expected and capturing any issues early.

### 5. Ease of Use:
- **Simple Setup**: Easy-to-run Bash scripts automate the setup and verification of firewall rules and packet inspection.
- **Administrative Control**: Uses sudo to ensure the necessary permissions for modifying firewall rules and capturing network packets.

### 6. Security Enhancement:
- **Layered Security**: Combines traditional firewall rule enforcement with real-time packet inspection, providing a multi-layered security approach.
- **Visibility and Logging**: Enhances network visibility and logging, aiding in monitoring and troubleshooting network activity.

## Coding

### Basic Firewall Script (`basic_firewall.sh`)

#### 1. Flush Existing Rules
- `iptables -F`: Flushes all the current rules in the `filter` table. This means it removes all the existing rules that are in place.
- `iptables -X`: Deletes all user-defined chains. This clears out any custom chains that might have been created previously.

#### 2. Set Default Policies
- `iptables -P INPUT DROP`: Sets the default policy for the `INPUT` chain to `DROP`. This means any incoming traffic that doesn't match an existing rule will be dropped.
- `iptables -P FORWARD DROP`: Sets the default policy for the `FORWARD` chain to `DROP`. This applies to packets being routed through the host. Since it's set to `DROP`, any forwarded packets will be dropped unless specifically allowed.
- `iptables -P OUTPUT ACCEPT`: Sets the default policy for the `OUTPUT` chain to `ACCEPT`. This means outgoing traffic is allowed by default.

#### 3. Allow Loopback Traffic
- `iptables -A INPUT`: Appends a new rule to the `INPUT` chain.
- `-i lo`: Specifies the loopback interface (typically `lo`). The loopback interface is used for local communication within the host.
- `-j ACCEPT`: Jumps to the `ACCEPT` target if the rule matches, meaning the traffic will be accepted.
- This rule allows traffic coming from the loopback interface, which is necessary for local system operations.

#### 4. Allow Established Connections
- `-m conntrack`: Uses the `conntrack` module, which allows stateful tracking of connections.
- `--ctstate ESTABLISHED,RELATED`: Specifies the states of connections to match. ESTABLISHED means an existing connection, and `RELATED` means new connections related to an existing connection (like an FTP data transfer).
- `-j ACCEPT`: Accepts the packets if they match this rule.
- This rule allows incoming packets that are part of an already established connection or related to an existing connection.

#### 5. Allow SSH
- `-p tcp`: Specifies the protocol to match, which is TCP in this case.
- `--dport 22`: Specifies the destination port to match, which is port 22 (the default port for SSH).
- `-j ACCEPT`: Accepts the packets if they match this rule.
- This rule allows incoming SSH connections, enabling remote administration via SSH.

#### 6. Allow HTTP and HTTPS
- `-p tcp`: Specifies the protocol to match, which is TCP.
- `--dport 80`: Specifies the destination port to match, which is port 80 (the default port for HTTP).
- `-j ACCEPT`: Accepts the packets if they match this rule.
- `--dport 443`: Specifies the destination port to match, which is port 443 (the default port for HTTPS).
- These rules allow incoming HTTP and HTTPS connections, enabling web traffic to reach your server.

#### 7. Confirmation Message
- `echo "Basic firewall rules configured."`: Prints a confirmation message to the console indicating that the basic firewall rules have been successfully configured.

### Packet Inspection Script (`packet_inspection.py`)

#### 1. Import Scapy
- This imports all the necessary components from the Scapy library, which will be used to sniff and analyze packets.

#### 2. Define the Packet Callback Function
- **Function Definition**: `def packet_callback(packet):` defines a function named `packet_callback` that takes a single argument `packet`.
- **Layer Check**: `if packet.haslayer(scapy.IP):` checks if the packet contains an IP layer. Scapy supports multiple layers (Ethernet, IP, TCP, etc.), and this line ensures that the packet has an IP layer.
- **Get IP Layer**: `ip_layer = packet.getlayer(scapy.IP)` retrieves the IP layer from the packet.
- **Print Packet Information**: `print(f"New Packet: {ip_layer.src} -> {ip_layer.dst}")` prints the source and destination IP addresses of the packet. ip_layer.src gives the source IP address, and `ip_layer.dst` gives the destination IP address.

#### 3. Define the Main Function
- **Function Definition**: `def main():` defines a function named `main`.
- **Sniff Packets**: `scapy.sniff(prn=packet_callback, store=0)` starts sniffing network packets.
  - `prn=packet_callback`: Specifies the callback function (`packet_callback`) to be called for each packet captured. This function processes each packet.
  - `store=0`: Tells Scapy not to store the packets in memory. This is useful for long-running packet captures to avoid consuming too much memory.

#### 4. Main Execution Block
- This block ensures that the `main` function is called only when the script is executed directly, not when it is imported as a module in another script. `if __name__ == "__main__":` is a common Python idiom to make code both importable and executable.

### NGFW Script (`ngfw.sh`)

#### 1. Script Breakdown
- `#!/bin/bash`: This shebang line specifies that the script should be run using the Bash shell.

#### 2. Load Basic Firewall Rules
- `# Load basic firewall rules`: This is a comment explaining that the following line will load the basic firewall rules.
- `sudo ./scripts/basic_firewall.sh`: This command runs the `basic_firewall.sh` script with superuser (sudo) privileges. This is necessary because modifying firewall rules typically requires administrative access.

#### 3. Run Packet Inspection
- `# Run packet inspection`: This is a comment explaining that the following line will run the packet inspection script.
- `sudo python3 ./scripts/packet_inspection.py`: This command runs the `packet_inspection.py` script using Python 3 with superuser (sudo) privileges. Packet sniffing often requires administrative access to capture all network traffic.

### Test Script (`test_firewall_rules.sh`)

#### 1. Script Breakdown
- `#!/bin/bash`: This shebang line specifies that the script should be run using the Bash shell.

#### 2. Test if iptables Rules are Set
- `# Test if iptables rules are set`: This is a comment explaining that the following command will test if the iptables rules are correctly configured.
- `iptables -L -v`: This command lists all current iptables rules with detailed information (`-v` for verbose). It helps verify that the firewall rules have been applied as expected.

#### 3. Test if Packet Inspection Script Runs without Errors
- `# Test if packet inspection script runs without errors`: This comment indicates that the following lines will test the packet inspection script.
- `python3 ./scripts/packet_inspection.py &`: This command runs the `packet_inspection.py` script in the background. The ampersand (`&`) at the end puts the process in the background, allowing the script to continue executing subsequent commands without waiting for the Python script to finish.
- `PID=$!`: This captures the Process ID (PID) of the last background process (`packet_inspection.py`) and stores it in the `PID` variable. This allows the script to manage the background process later.

#### 4. Wait and then Kill the Process
- `# Wait and then kill the process`: This comment explains that the script will wait for a specified time and then terminate the background process.
- `sleep 60`: This command makes the script wait for 60 seconds. During this time, the packet inspection script runs and captures packets.
- `kill $PID`: This command terminates the process with the PID stored in the `PID` variable, effectively stopping the packet inspection script after 60 seconds.
