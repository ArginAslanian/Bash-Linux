# Configuring linux server as a file server - ubuntu server

# Update and upgrade the system packages
sudo apt update && sudo apt upgrade -y

# Install Samba file server
sudo apt install samba -y
sudo systemctl enable smbd
sudo systemctl start smbd

# Verify Samba service is running
sudo systemctl status smbd

# Create a directory to share
sudo mkdir -p /srv/fileshare
sudo chown -R $USER:$USER /srv/fileshare  # Change ownership to current user
sudo chmod -R 2770 /srv/fileshare         # Set permissions for the share directory (2770 for group write access. 2775 if we want read access for others)

# Configure Samba to share the directory
sudo vim /etc/samba/smb.conf

# Add the following at the end of the file:
[fileshare]
   path = /srv/fileshare
   browsable = yes
   writable = yes
   read only = no
   guest ok = no
   valid users = @sambashare

# Then save and exit vim 
# Esc :wq

# Create a Samba user and set password
sudo useradd -m sambauser               # Create a new user for Samba
# sudo groupadd sambashare                # Create sambashare group
# sudo usermod -aG sambashare sambauser   # Add user to sambashare group
sudo smbpasswd -a sambauser             # Set Samba password for the user
sudo smbpasswd -e sambauser             # Enable the Samba user
sudo pdbedit -L                         # List Samba users to verify

# Restart Samba service to apply changes
sudo systemctl restart smbd     # Restart Samba daemon
sudo systemctl restart nmbd     # Restart NetBIOS name server
sudo systemctl restart samba    # Restart Samba service
sudo systemctl restart samba-ad-dc  # Restart Samba AD DC service if applicable

# Configure Firewall
sudo ufw allow ssh
sudo ufw allow samba
sudo ufw enable
sudo ufw reload # Reload firewall to apply changes

# Check firewall status
sudo ufw status

# Test Samba share locally
smbclient //localhost/fileshare -U sambauser
# Enter the password when prompted and use commands like 'ls' to list files
# and 'put' to upload files
# Example commands after connecting:
# smb: \> ls
# smb: \> put localfile.txt remotefile.txt  
# smb: \> exit

# Create mount point
# Install cifs-utils if not already installed
sudo apt install cifs-utils -y
sudo mkdir -p /mnt/fileshare

# Mount the Samba share 
sudo mount -t cifs //SERVER_IP/fileshare /mnt/fileshare -o username=sambauser,uid=1000,gid=1000
# Replace SERVER_IP with the actual server IP address

# Mount the fileshare on another linux machine
sudo mount -t cifs //SERVER_IP/fileshare /mnt/fileshare -o username=sambauser,uid=1000,gid=1000
# Replace SERVER_IP with the actual server IP address

# To make the mount persistent across reboots, add the following line to /etc/fstab
//SERVER_IP/fileshare /mnt/fileshare cifs username=sambauser,password=YOUR_PASSWORD,uid=1000,gid=1000 0 0
# Replace SERVER_IP and YOUR_PASSWORD with actual values

sudo vim /etc/fstab
# Add the above line, then save and exit vim
# Esc :wq

# Secure credentials
sudo vim /root/.smbcredentials
# Add the following lines:
username=sambauser
password=YOUR_PASSWORD
# Save and exit vim
# Esc :wq
sudo chmod 600 /root/.smbcredentials # Secure the credentials file
# Then modify the fstab entry to use the credentials file
//SERVER_IP/fileshare /mnt/fileshare cifs credentials=/root/.smbcredentials,uid=1000,gid=1000 0 0
# Then save and exit vim
# Esc :wq

# Test mount
sudo mount -a

################################ 
# Troubleshooting mount issues #
################################

# Mount fails at boot:
# Add 'nofail' option to the fstab entry to prevent boot failure
//SERVER_IP/fileshare /mnt/fileshare cifs credentials=/root/.smbcredentials,uid=1000,gid=1000,nofail 0 0
# Then save and exit vim
# Esc :wq
# Ensure _netdev_ option is added for network filesystems
//SERVER_IP/fileshare /mnt/fileshare cifs credentials=/root/.smbcredentials,uid=1000,gid=1000,_netdev_ 0 0
# Then save and exit vim
# Esc :wq
# Check logs
sudo journalctl -xe
# Then run
sudo mount -a

# Permission denied errors:
# Check Samba share permissions and ensure the user has access
ls -ld /srv/fileshare

# Ensure correct permissions on the shared directory
sudo chown -R nobody:nogroup /srv/fileshare
sudo chmod -R 2775 /srv/fileshare # 2775 for read access to others, 2770 for group write access only

# Check samba users
sudo pdbedit -L

# Wrong filesystem type:
# Ensure 'cifs' is used for mounting Samba shares, not 'smbfs'
# Ensure cifs-utils is installed
sudo apt install cifs-utils -y

# Host unreachable:
# Check network connectivity
ping SERVER_IP
# Ensure firewall allows Samba traffic
sudo ufw allow samba
sudo ufw reload
# Check Samba service status
sudo systemctl status smbd
# Check ports
sudo ss -tuln | grep 139
sudo ss -tuln | grep 445
# Check firewall
sudo ufw status

# fstab syntax errors:
# Ensure no extra spaces or incorrect characters in fstab entries
sudo vim /etc/fstab
# Validate syntax and save
# Esc :wq   

# SELinux blocking access 

getenforce # Check SELinux status
# If enforcing, consider setting to permissive for testing
sudo setenforce 0
# Persistent:
sudo setsebool -P samba_export_all_rw on # Allow Samba read/write access

# Check Logs
sudo tail -f /var/log/samba/log.smbd
sudo tail -f /var/log/samba/log.nmbd
sudo tail -f /var/log/syslog
sudo tail -f /var/log/messages
sudo journalctl -xe
sudo journalctl -u smbd
sudo journalctl -u nmbd
sudo journalctl -u samba
sudo journalctl -u samba-ad-dc

# Syncing files between two linux file servers using rsync over SSH
# On source server
rsync -avz -e ssh /srv/fileshare/ user@destination_server_ip:/srv/fileshare/
# Replace user and destination_server_ip with actual values

# Set up cron job for periodic sync
crontab -e
# Add the following line for daily sync at 2 AM
0 2 * * * rsync -avz -e ssh /srv/fileshare/ user@destination_server_ip:/srv/fileshare/
# Save and exit vim
# Esc :wq   

# sync files using linux workstation
rsync -avz -e ssh /local/directory/ user@file_server_ip:/srv/fileshare/
# Replace /local/directory/, user, and file_server_ip with actual values    
# On destination server, verify files
ls -l /srv/fileshare

# Check rsync logs if any issues
sudo tail -f /var/log/syslog
sudo journalctl -xe 