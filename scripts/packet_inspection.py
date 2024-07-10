import scapy.all as scapy

def packet_callback(packet):
    if packet.haslayer(scapy.IP):
        ip_layer = packet.getlayer(scapy.IP)
        print(f"New Packet: {ip_layer.src} -> {ip_layer.dst}")

def main():
    scapy.sniff(prn=packet_callback, store=0)

if __name__ == "__main__":
    main()
