# Network and IP commands

# Display IP address information
ip addr show              # Show all IP addresses assigned to interfaces
ip addr show eth0         # Show IP address information for a specific interface (replace eth0)
ip addr show wlan0        # Show IP address information for a wireless interface (replace wlan0)
ip a                      # Short form of ip addr show

# Display routing information
ip route show             # Show the routing table
ip route show default     # Show the default gateway
ip route show table all   # Show all routing tables
ip route show table main  # Show the main routing table
ip route show table local # Show the local routing table

# Display network interfaces
ip link show              # Show all network interfaces
ip link show eth0         # Show information for a specific interface (replace eth0)
ip link show wlan0        # Show information for a wireless interface (replace wlan0)

# Display ARP table
ip neigh show             # Show ARP table for all interfaces
ip neigh show eth0         # Show ARP table for a specific interface (replace eth0)
ip neigh show wlan0        # Show ARP table for a wireless interface (replace wlan0

# Check network connectivity
ping -c 4 google.com      # Test connectivity to an external host
ping -c 4 server.local    # Test connectivity to a local host (replace server.local)
traceroute google.com     # Trace the route packets take to a host
mtr google.com            # Network diagnostic tool combining ping and traceroute

# Display network statistics
ss -s                     # Display summary statistics for all protocols
ss -tuln                  # List all listening TCP and UDP ports
ss -s state established   # Show established connections
ss -s state listening     # Show listening sockets
ss -s state closed        # Show closed connections

# Request a new IP address via DHCP
sudo dhclient -r          # Release the current DHCP lease
sudo dhclient eth0        # Request a new DHCP lease for a specific interface (replace eth0)
sudo dhclient wlan0       # Request a new DHCP lease for a wireless interface (replace wlan0)
