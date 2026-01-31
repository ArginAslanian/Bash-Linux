# Linux ubuntu server configuration as a Domain Controller (DC) using Samba 

# Set hostname and static IP address
sudo hostnamectl set-hostname dc1.your.domain.com

# Edut host file
sydo vim /etc/hosts
# Add the following line
127.0.0.1   localhost
192.168.1.10 dc1.your.domain.com dc1
# Save and exit vim
# Esc :wq

# Apply the static IP configuration
exec bash

# Configure network interface with static IP
sudo vim /etc/netplan/01-netcfg.yaml
# Add the following configuration (modify as needed)
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        -192.168.1.10/24
      gateway4: 192.168.1.1
        nameservers:
            addresses:
            - 192.168.1.1
# Save and exit vim
# Esc :wq

# Apply netplan configuration
sudo netplan apply  

# Verify network configuration
ip a

# Update and upgrade the system packages
sudo apt update && sudo apt upgrade -y

# Install Samba and related packages for AD DC
sudo apt install samba smbclient krb5-user winbind libnss-winbind libpam-winbind -y
sudo systemctl enable smbd nmbd winbind samba-ad-dc
sudo systemctl start smbd nmbd winbind samba-ad-dc

# Verify Samba AD DC service is running
sudo systemctl status samba-ad-dc   

# Configure DNS resolver
sudo vim /etc/resolv.conf
# Add the following line (replace with your domain and DC IP)
search your.domain.com
nameserver 192.168.1.10
# Save and exit vim
# Esc :wq

# Provision the Samba AD DC
sudo samba-tool domain provision --use-rfc2307 --interactive

# Follow the prompts to set up the domain (e.g., domain name, realm, admin password)

# Start Samba AD DC service
sudo systemctl unmask samba-ad-dc
sudo systemctl enable samba-ad-dc
sudo systemctl start samba-ad-dc

# Verify Samba AD DC service is running
sudo systemctl status samba-ad-dc

# Verify Domain Health
sudo samba-tool domain level show
sudo samba-tool dbcheck

# List users
sudo samba-tool user list

# Check DNS
host dc1.your.domain.com

# Kerberos test
kinit administrator
klist

# Managing AD objects
# Add a new user
sudo samba-tool user create johndoe P@ssw0rd
# Enable the user
sudo samba-tool user enable johndoe
# Reset user password
sudo samba-tool user setpassword johndoe --newpassword=P@ssw0rd123
# Add a new group
sudo samba-tool group create "IT Department"
# Add user to group
sudo samba-tool group addmembers "IT Department" johndoe

# Configure Firewall
sudo ufw allow ssh
sudo ufw allow samba
sudo ufw allow dns
sudo ufw allow kerberos
sudo ufw enable
sudo ufw reload # Reload firewall to apply changes

# Check firewall status
sudo ufw status

# Join a Windows client to the domain
# On the Windows client, go to System Properties > Change settings > Change...
# Select "Domain" and enter "your.domain.com"
# Provide the credentials of the domain administrator when prompted
# Verify the Windows client is joined to the domain
# Test domain join from the Linux DC
sudo samba-tool domain join your.domain.com DC -U"administrator" # Use the domain admin credentials when prompted
# Verify the join
sudo samba-tool domain level show
# Reboot the system to ensure all changes take effect
sudo systemctl reboot
# After reboot, verify Samba AD DC service is running
sudo systemctl status samba-ad-dc

#########################################
# Troubleshooting

# Samba wont start
sudo journalctl -xe
sudo tail -n 50 /var/log/samba/log.smbd
sudo tail -n 50 /var/log/samba/log.nmbd
sudo tail -n 50 /var/log/samba/log.winbindd

# Check Samba configuration for errors
testparm

# Kerberos fails
sudo kinit administrator
# Check time synchronization
timedatectl status
# Sync time if needed
sudo timedatectl set-ntp true

# DNS issues
host your.domain.com
ss -tuln | grep 53

# Clients cant join domain
ping dc1.your.domain.com
nslookup dc1.your.domain.com
# DNS must point to the DC IP address
nltest /dsgetdc:your.domain.com
# Verify network connectivity
traceroute dc1.your.domain.com
# Firewall issues
sudo ufw status 
sudo ufw allow samba
sudo ufw allow 53
sudo ufw reload

# Logs
journalctl -u samba-ad-dc
sudo tail -f /var/log/samba/log.smbd
sudo tail -f /var/log/samba/log.nmbd