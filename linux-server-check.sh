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