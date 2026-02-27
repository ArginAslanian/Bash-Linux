# Check all services that are running on the server
sudo systemctl list-units --type=service --state=running

# Check all services that are not running on the server
sudo systemctl list-units --type=service --state=inactive

# Check all ports that are open on the server
ss -tuln
ss -tulpen

# Check all the ports that are listening on the server
sudo lsof -i -P -n | grep LISTEN

# Enable ports 21, 22, 25, 80, 110, 143, 443 for lab testing
sudo ufw allow 21/tcp
sudo ufw allow 22/tcp
sudo ufw allow 25/tcp
sudo ufw allow 80/tcp
sudo ufw allow 110/tcp
sudo ufw allow 143/tcp
sudo ufw allow 443/tcp

# Check the status of the firewall
sudo ufw status
sudo ufw enable
sudo ufw status verbose

# ON THE LAB SERVER MACHINE (NOT CONNECTED TO INTERNET)
# Once NAT adapter is attached, need to get an IP address from the DHCP server on the host machine
ip a                # to find the interface name (e.g., eth0, enp0s3, etc.)
sudo dhclient -r <interface_name>  # to release the current IP address
sudo dhclient <interface_name>     # to request a new IP address from the DHCP server
ip a                # to verify the new IP address has been obtained
