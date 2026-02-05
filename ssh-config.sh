# ssh configuration for connecting to a linux server
# Linux Ubuntu server running on vmware
# Linux Ubuntu client running on a local machine
# SSH connection using key-based authentication
# New users will be created on the server side for SSH access

############
# Make sure SSH is installed and running on the server and is allowed through the firewall
############
# On the server side, install OpenSSH server if not already installed
sudo apt update
sudo apt install openssh-server -y
# on the client machine, install OpenSSH client if not already installed
sudo apt update
sudo apt install openssh-client -y
############
# Check the status of the SSH service
sudo systemctl status ssh
# Enable and start the SSH service if not already running
sudo systemctl enable ssh
sudo systemctl start ssh
# Allow SSH through the firewall
sudo ufw allow ssh
sudo ufw enable 
sudo ufw status
############

########################################
### On the server side (Linux Ubuntu server)
########################################
# Connect to the server using the main user created during VM setup with password
# ssh mainuser@server_ip_address
# Once connected, create a new user for SSH access
# 1. Create a new user (if not already created)
sudo adduser bob

# 2. Add the new user to the sudo group (optional, if sudo privileges are needed)
sudo usermod -aG sudo bob

# 3. Add user to the ssh group (if you want to restrict ssh access to specific users)
sudo usermod -aG ssh bob

# 4. Grant SSH access by creating the .ssh directory and authorized_keys file
sudo mkdir -p /home/bob/.ssh                            # Create .ssh directory (mkdir -p creates parent directories as needed)
sudo chmod 700 /home/bob/.ssh                           # Set directory permissions to be accessible only by the user. 700 because rwx for user, no permissions for group/others
sudo chown bob:bob /home/bob/.ssh                       # Change ownership of the .ssh directory to the new user                            
sudo touch /home/bob/.ssh/authorized_keys               # Create authorized_keys file to be used for key-based authentication
sudo chmod 600 /home/bob/.ssh/authorized_keys           # Set file permissions to be read/write for the user only. 600 because rw for user, no permissions for group/others
sudo chown bob:bob /home/bob/.ssh/authorized_keys       # Change ownership of the authorized_keys file to the new user

# 5. Add the public key of the client machine to the authorized_keys file
# ssh keys live on the client machine in ~/.ssh/
# Most common; ~/.ssh/id_ed25519.pub   ← public key (modern, recommended)
# ~/.ssh/id_ed25519       ← private key (NEVER share)
# ~/.ssh/id_rsa.pub       ← public key (older)
# ~/.ssh/id_rsa           ← private key
# On the client machine, get the public key:
# cat ~/.ssh/id_ed25519.pub   # or cat ~/.ssh/id_rsa.pub
# Copy the output and send it to the server administrator to be added to the authorized_keys file
# Admin Append it to the authorized_keys file:
echo "ssh-ed25519 AAAAB3NzaC1yc2EAAAABIwAAAQEAr... user@client_machine" | sudo tee -a /home/bob/.ssh/authorized_keys # Replace with the actual public key from the client machine
# tee -a appends the key to the file

######
# User can generate a new SSH key pair on the client machine if they don't have one:
# On the client machine, run:
# ssh-keygen -t ed25519
######

# 6. Set correct ownership and permissions again (just to be sure)
sudo chown -R bob:bob /home/bob/.ssh                # -R for recursive
sudo chmod 700 /home/bob/.ssh
sudo chmod 600 /home/bob/.ssh/authorized_keys

# 7. User bob can now connect from the client machine using key-based authentication
ssh bob@server_ip_address

######################################
######################################
# to allow users to send their public keys themselves, you can set up a temporary method:
# Create the user and password, and set up the .ssh directory and authorized_keys file as shown above.
# Then instruct the user to connect using password authentication.
# On the server, enable password authentication temporarily:
sudo vim /etc/ssh/sshd_config
# Find the line:
# PasswordAuthentication no
# Change it to:
# PasswordAuthentication yes
# Save and exit the file, then restart the SSH service:
sudo systemctl restart sshd
# Now the user can connect using their password:
ssh bob@server_ip_address
# Once connected, the user can add their public key to the authorized_keys file as shown above
# The client user can use the following command to append their public key directly:
ssh-copy-id bob@server_ip_address
# After the user has added their key, disable password authentication again for security:
sudo vim /etc/ssh/sshd_config
# Change the line back to:
# PasswordAuthentication no
# Save and exit the file, then restart the SSH service:
sudo systemctl restart sshd
######################################
######################################
