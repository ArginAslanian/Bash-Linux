# Configuring a linux web server - ubuntu server

# Update and upgrade the system packages
sudo apt update && sudo apt upgrade -y

# Install Apache web server
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2

# or nginx web server
# sudo apt install nginx -y
# sudo systemctl enable nginx
# sudo systemctl start nginx

# Verify web server is running
sudo systemctl status apache2
# or for nginx
# sudo systemctl status nginx

# Test locally
curl localhost

# Configure Firewall
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Check firewall status
sudo ufw status

# Create a sample HTML file
sudo mkdir -p /var/www/website.com/html         # Create directory for website
sudo chown -R $USER:$USER /var/www/website.com  # Change ownership to current user
sudo chmod -R 755 /var/www                      # Set permissions for web directory 

# Create a sample index.html file
vim /var/www/website.com/html/index.html

# Inside vim, add the following HTML content:
<html>
  <head><title>My Web Server</title></head>
  <body>
    <h1>It works!</h1>
  </body>
</html>

# Then save and exit vim
# Esc :wq

# Open the website in a browser using server IP or domain
# http://your_server_ip/ or http://website.com/

# Basic security hardening
sudo apt install ufw fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Disable root login via SSH
sudo vim /etc/ssh/sshd_config  
# Change 'PermitRootLogin yes' to 'PermitRootLogin no'
# Save and exit vim
sudo systemctl restart sshd

# Check logs
sudo tail -f /var/log/apache2/access.log
sudo tail -f /var/log/apache2/error.log
# or for nginx
# sudo tail -f /var/log/nginx/access.log
# sudo tail -f /var/log/nginx/error.log

# Restart web server to apply changes
sudo systemctl restart apache2
# or for nginx
# sudo systemctl restart nginx