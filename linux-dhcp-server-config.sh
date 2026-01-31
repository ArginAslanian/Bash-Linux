# Setting up a DHCP server on Linux Ubuntu Server
# Install DHCP server package
sudo apt update
sudo apt install isc-dhcp-server -y

# Specify the network interface for DHCP server
sudo vim /etc/default/isc-dhcp-server
# Set INTERFACESv4="eth0" (replace eth0 with your network interface)
# Save and exit vim
# Esc :wq

# Cofigure DHCP Scope
sudo vim /etc/dhcp/dhcpd.conf
# Add the following configuration (modify according to your network settings):
authoritative;              # Declare this DHCP server as authoritative

default-lease-time 600;     # Default lease time in seconds
max-lease-time 7200;        # Maximum lease time in seconds
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
    option routers 192.168.1.1;
    option subnet-mask 255.255.255.0;
    option domain-name "localdomain";
    option domain-name-servers 192.168.1.1;
}
# Save and exit vim
# Esc :wq   

# Validate DHCP configuration
sudo dhcpd -t # if no errors (it returns to prompt), proceed to next step

# Restart DHCP server to apply changes
sudo systemctl restart isc-dhcp-server  

# Start and enable DHCP server
sudo systemctl enable isc-dhcp-server
sudo systemctl restart isc-dhcp-server

# Check DHCP server status
sudo systemctl status isc-dhcp-server

# Firewall configuration
sudo ufw allow dhcp
sudo ufw allow 67/udp
sudo ufw enable
sudo ufw reload # Reload firewall to apply changes

# Test on a client
sudo dhclient -v

# Check IP
ip a

# DHCP Reservations (Optional)
# To reserve an IP address for a specific MAC address, add the following to /etc/dhcp/dhcpd.conf
sudo vim /etc/dhcp/dhcpd.conf
# Add the following block inside the subnet declaration:
host reservedclient {
  hardware ethernet 00:11:22:33:44:55; # Replace with the client's MAC address
  fixed-address 192.168.1.150; # Assign a fixed IP address to this client
}
# Save and exit vim
# Esc :wq
# Restart DHCP server to apply reservation changes
sudo systemctl restart isc-dhcp-server


################################
# Troubleshooting 

# DHCP service wont start
# Check the status and logs for errors
sudo systemctl status isc-dhcp-server
sudo journalctl -xe | grep dhcp
sudo journalctl -u isc-dhcp-server

# Clients not getting IP addresses
# Ensure the DHCP server is running and the firewall allows DHCP traffic
sudo systemctl status isc-dhcp-server
sudo ufw status
# Verify DHCP is listening
sudo netstat -ulnp | grep dhcpd
ss -uln | grep 67

# Multiple DHCP servers on the same network
sudo tcpdump -i eth0 port 67 or port 68
# Identify and disable any conflicting DHCP servers

# Wrong DNS or Gateway settings
# Check dhcpd.conf for correct options
sudo vim /etc/dhcp/dhcpd.conf
# Ensure options for routers and domain-name-servers are correct
# Save and exit vim
# Esc :wq
cat /var/lib/dhcp/dhcpd.leases # Check assigned leases
# Restart DHCP server after changes
sudo systemctl restart isc-dhcp-server

# Clients get APIPA addresses (169.254.x.x)
# Logs 
sudo tail -f /var/log/syslog | grep dhcp
journalctl -u isc-dhcp-server