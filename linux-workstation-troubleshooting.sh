# Common issues and troubleshooting steps for a Linux workstation 
# 1. Network Connectivity Issues
# Check if the network interface is up
ip link show
# Restart network service
sudo systemctl restart NetworkManager
# Check IP address configuration
ip addr show
# Test connectivity to gateway
ping -c 4 <gateway_ip>
# Check DNS resolution
nslookup google.com 

# 2. Slow Performance
# Check CPU and memory usage
top
# Check for I/O wait
iostat -x 1 10
# Check for disk space issues
df -h
# Check for running processes consuming high resources
ps aux --sort=-%cpu | head -n 10
ps aux --sort=-%mem | head -n 10    
# Check for background services
systemctl list-units --type=service --state=running
# Disable unnecessary startup applications
systemctl disable <service_name>    

# 3. Application Crashes
# Check application logs
cat /var/log/<application_name>.log
# Reinstall the application
sudo apt-get install --reinstall <application_name>
# Check for missing dependencies
ldd /usr/bin/<application_name> 
# Update the application
sudo apt-get update && sudo apt-get upgrade <application_name>

# 4. Printer Issues
# Check printer status
lpstat -p
# Restart CUPS service
sudo systemctl restart cups
# Check printer queue
lpq
# Reinstall printer drivers
sudo apt-get install --reinstall <printer_driver_package>
# Add printer again
sudo lpadmin -p <printer_name> -E -v <device_uri> -m <model>

# 5. Software Update Problems
# Check for broken packages
sudo apt-get check
# Fix broken packages
sudo apt-get install -f
# Clear package cache
sudo apt-get clean
# Update package lists
sudo apt-get update
# Upgrade packages
sudo apt-get upgrade -y
# Dist-upgrade for major updates
sudo apt-get dist-upgrade -y
# Check for held back packages
sudo apt-mark showhold
# Unhold packages if necessary
sudo apt-mark unhold <package_name>

# 6. File Permission Issues
# Check file permissions
ls -l /path/to/file_or_directory
# Change ownership
sudo chown user:group /path/to/file_or_directory
# Change permissions
sudo chmod 755 /path/to/file_or_directory
# Use ACLs for more granular permissions
sudo setfacl -m u:username:rwx /path/to/file_or_directory   
# View ACLs
getfacl /path/to/file_or_directory

# 7. Hardware Recognition Issues
# Check connected hardware
lspci
lsusb
# Check kernel messages for hardware detection
dmesg | grep -i <hardware_name>
# Load necessary drivers
sudo modprobe <driver_name>
# Update initramfs
sudo update-initramfs -u
# Reboot the system
sudo reboot

# 8. Audio Issues
# Check audio device status
aplay -l
# Restart PulseAudio
pulseaudio -k
pulseaudio --start
# Check volume levels
alsamixer
# Reinstall audio drivers
sudo apt-get install --reinstall alsa-base pulseaudio   
# Test audio output
speaker-test -c 2

# 9. Display Issues
# Check connected displays
xrandr
# Restart display manager
sudo systemctl restart gdm3  # or lightdm, sddm depending on your display manager
# Reconfigure display settings
xrandr --output <display_name> --mode <resolution>
# Reinstall graphics drivers
sudo apt-get install --reinstall <graphics_driver_package>
# Check Xorg logs for errors
cat /var/log/Xorg.0.log | grep -i error 

# 10. Bluetooth Issues
# Check Bluetooth status
systemctl status bluetooth
# Restart Bluetooth service
sudo systemctl restart bluetooth
# Check for paired devices
bluetoothctl paired-devices
# Reinstall Bluetooth drivers
sudo apt-get install --reinstall bluez
# Scan for devices
bluetoothctl scan on    
# Pair and connect to a device
bluetoothctl pair <device_mac>
bluetoothctl connect <device_mac>
# Trust the device
bluetoothctl trust <device_mac>

# 11. Login Issues
# Check authentication logs
cat /var/log/auth.log | grep -i login
# Reset user password
sudo passwd <username>
# Check for disk space issues on root partition
df -h /
# Check for corrupted user profile
mv /home/<username> /home/<username>_backup
sudo mkdir /home/<username>
sudo chown <username>:<username> /home/<username>
# Reboot the system
sudo reboot

# 12. "Home Directory is Full" Issue
# Check disk usage of home directory
df -h /home
# Check quota for the user
quota -u <username>
# Remove unnecessary files from home directory
rm -rf /home/<username>/Downloads/*
# Check for large files
du -sh /home/<username>/* | sort -h
# Clear package cache
sudo apt-get clean
# Check for open files in home directory
lsof +D /home/<username>
# Reboot the system
sudo reboot 

# 13. Samba Share Access Issues
# Check if the Samba service is running
sudo systemctl status smbd nmbd
# Check smb.conf for correct share definitions
sudo vim /etc/samba/smb.conf
# Test Samba configuration
testparm
# Check Samba user credentials
sudo pdbedit -L
# Check file system permissions on the shared directory
ls -ld /srv/fileshare
# Check Samba logs for errors
sudo tail -f /var/log/samba/log.smbd
# Restart Samba services
sudo systemctl restart smbd nmbd
# Check network connectivity to the Samba server
ping <samba_server_ip>
# Ensure firewall allows Samba traffic
sudo ufw allow samba
# Check SELinux context if SELinux is enabled
ls -Z /srv/fileshare    
# Set correct SELinux context if needed
sudo chcon -t samba_share_t /srv/fileshare -R
# Test access using smbclient
smbclient //<samba_server_ip>/fileshare -U <samba_user>
# Check path permissions leading to the share directory
ls -ld /srv
ls -ld /srv/fileshare   
# Ensure 'cifs' is used for mounting Samba shares, not 'smbfs'
# Ensure cifs-utils is installed
sudo apt-get install cifs-utils -y
# Check fstab for correct Samba share mount syntax
sudo vim /etc/fstab
# Remount all filesystems
sudo mount -a   
# Reboot the system
sudo reboot

# 14. Printer Not Responding Issue
# Check printer status
lpstat -p
# Restart CUPS service
sudo systemctl restart cups
# Check printer queue
lpq
# Reinstall printer drivers
sudo apt-get install --reinstall <printer_driver_package>
# Add printer again
sudo lpadmin -p <printer_name> -E -v <device_uri> -m <model>
# Check CUPS error logs
sudo tail -f /var/log/cups/error_log
# Check network connectivity to network printer
ping <printer_ip>
# Ensure firewall allows printer traffic
sudo ufw allow 631/tcp
# Reboot the system
sudo reboot 

# System Maintenance Commands
# System Updates (for Debian/Ubuntu)
sudo apt update           # Update package lists
sudo apt upgrade -y       # Upgrade all installed packages
sudo apt dist-upgrade -y  # Perform a distribution upgrade
sudo apt autoremove -y    # Remove unnecessary packages 
sudo apt clean            # Clean up the local repository of retrieved package files    
# System Updates (for RedHat/CentOS)
sudo yum check-update     # Check for available package updates
sudo yum update -y        # Update all installed packages
sudo yum upgrade -y       # Perform a distribution upgrade
sudo yum autoremove -y    # Remove unnecessary packages
sudo yum clean all        # Clean up the local repository of retrieved package files    
# Logs and System Monitoring
dmesg                     # Display kernel ring buffer messages
journalctl -xe            # View systemd journal logs with priority
journalctl -u <service>   # View logs for a specific service
journalctl -b              # View logs from the current boot
journalctl --since "2024-01-01" --until "2024-01-02"  # View logs within a specific date range    
tail -f /var/log/syslog   # Continuously monitor system log file
tail -f /var/log/messages # Continuously monitor messages log file    
# Monitor network traffic in real-time
iftop                     # Display bandwidth usage on an interface
htop                      # Interactive process viewer
nload                     # Monitor network traffic and bandwidth usage
vmstat 1                  # Display system performance statistics every second    
# System Control
systemctl reboot            # Reboot the system
systemctl poweroff          # Power off the system
systemctl suspend           # Suspend the system
systemctl hibernate         # Hibernate the system
shutdown -r +5              # reboot in 5 minutes
shutdown -h +10             # power off in 10 minutes
systemctl status <service>  # Check the status of a specific service
systemctl start <service>   # Start a specific service
systemctl stop <service>    # Stop a specific service
systemctl restart <service> # Restart a specific service
systemctl enable <service>  # Enable a service to start on boot
systemctl disable <service> # Disable a service from starting on boot
systemctl list-units --type=service  # List all active services 
env                        # Display all environment variables
# Cron Job Management
crontab -l                # List all scheduled cron jobs for the current user
crontab -e                # Edit the cron jobs for the current user
crontab -r                # Remove all cron jobs for the current user
cronctl list-timers       # List all active systemd timers
# Disk Management
lsblk                       # List all block devices
fdisk -l                    # List all disk partitions  

# 15. Mounting and Syncing Linux File Server Shares
# Mounting a Samba Share on Linux Workstation
# Create mount point
sudo mkdir -p /mnt/fileshare
# Mount the Samba share
sudo mount -t cifs -o username=sambauser,password=sambapassword //SERVER_IP/fileshare /mnt/fileshare
# Replace sambauser, sambapassword, SERVER_IP with actual values
# Verify the mount
df -h | grep fileshare
ls /mnt/fileshare
# To make the mount persistent, add to /etc/fstab
sudo vim /etc/fstab
# Add the following line:
//SERVER_IP/fileshare /mnt/fileshare cifs username=sambauser,password=sambapassword 0 0
# Save and exit vim
# Esc :wq
# Syncing Files to Samba Share using rsync
# Sync local directory to Samba share
rsync -av /path/to/local/dir/ /mnt/fileshare/
# Sync Samba share back to local directory
rsync -av /mnt/fileshare/ /path/to/local/dir/
# Replace /path/to/local/dir/ with actual local directory path  
# Unmount the Samba share when done
sudo umount /mnt/fileshare  

# 16. VPN wont connect
# Check VPN service status
sudo systemctl status openvpn   
# Restart VPN service
sudo systemctl restart openvpn
# Check VPN configuration file for errors
sudo vim /etc/openvpn/client.conf
# Test VPN connection manually
sudo openvpn --config /etc/openvpn/client.conf
# Check logs for errors
sudo tail -f /var/log/openvpn.log
# Ensure firewall allows VPN traffic
sudo ufw allow 1194/udp   # Adjust port and protocol as needed
# Check network connectivity to VPN server
ping <vpn_server_ip>
# Reboot the system 
sudo reboot

# 17. DNS is broken
# Check DNS configuration
cat /etc/resolv.conf
# Test DNS resolution
nslookup google.com
dig google.com
# Restart networking service
sudo systemctl restart NetworkManager
# Flush DNS cache
sudo systemd-resolve --flush-caches
# Check hosts file for incorrect entries
sudo vim /etc/hosts
# Test with different DNS server
nslookup google.com
# Update DNS settings in NetworkManager
sudo nmcli dev show | grep DNS
sudo nmcli con mod <connection_name> ipv4.dns "8.8.8.8"
sudo nmcli con up <connection_name>
# Reboot the system
sudo reboot

# 18. DHCP Issues
# Release and renew DHCP lease
sudo dhclient -r
sudo dhclient
# Check DHCP client status
sudo systemctl status dhclient
# Check DHCP lease file
cat /var/lib/dhcp/dhclient.leases
# Restart networking service
sudo systemctl restart NetworkManager
# Check for IP address assignment
ip addr show
# Reboot the system
sudo reboot

# 19. Laptop battery draining quickly
# Check battery status
upower -i /org/freedesktop/UPower/devices/battery_BAT0
# Install and use TLP for power management
sudo apt install tlp tlp-rdw -y
sudo tlp start
# Check TLP status
sudo tlp-stat
# Reduce screen brightness
xbacklight -set 50   # Set brightness to 50%
# Disable unused hardware (Bluetooth, WiFi)
sudo rfkill block bluetooth
sudo rfkill block wifi
# Check for power-hungry processes
top
# Adjust CPU scaling governor
sudo apt install cpufrequtils -y
sudo cpufreq-set -g powersave
# Reboot the system
sudo reboot 

# 20. Webcam not working
# Check if webcam is detected
lsusb | grep -i camera
# Check video devices
ls /dev/video*
# Install v4l-utils for webcam testing
sudo apt install v4l-utils -y
# Test webcam functionality
v4l2-ctl --list-devices
v4l2-ctl --list-formats-ext -d /dev/video0
# Use cheese to test webcam
sudo apt install cheese -y
cheese
# Check permissions on video device
ls -l /dev/video0
# Add user to video group if necessary
sudo usermod -aG video $USER
# Reboot the system
sudo reboot

# 21. After an update, system behaves unexpectedly
# Check recently installed packages
grep " install " /var/log/dpkg.log | tail -n 20
# Check for held back packages
sudo apt-mark showhold
# Rollback problematic packages if identified
sudo apt-get install <package_name>=<version_number>
# Clear package cache
sudo apt-get clean
# Reconfigure all packages
sudo dpkg --configure -a
# Check system logs for errors
journalctl -xe
# Boot into previous kernel version if kernel update caused issues
sudo grub-reboot 'Advanced options for Ubuntu>Ubuntu, with Linux <previous_version>'
sudo reboot
# Reboot the system
sudo reboot

# 22. Time and date are incorrect
# Check current date and time
date
# Check time zone settings
timedatectl
# Set correct time zone
sudo timedatectl set-timezone <Region/City>
# Sync time with NTP server
sudo apt install ntp -y
sudo systemctl enable ntp
sudo systemctl start ntp
sudo ntpq -p
# Manually set date and time if needed
sudo date -s "YYYY-MM-DD HH:MM:SS"
# Reboot the system
sudo reboot 

# 23. Machine is overheating
# Check CPU temperature
sudo apt install lm-sensors -y
sensors
# Clean dust from vents and fans
# Ensure proper ventilation
# Check for high CPU usage processes
top
# Adjust CPU frequency scaling
sudo apt install cpufrequtils -y
sudo cpufreq-set -g powersave
# Install and configure fan control
sudo apt install fancontrol -y
sudo pwmconfig
sudo service fancontrol start
# Reboot the system
sudo reboot

# 24. USB device not recognized
# Check connected USB devices
lsusb
# Check kernel messages for USB device detection
dmesg | grep -i usb
# Unplug and replug the USB device
# Try different USB port
# Check for necessary drivers
sudo lshw -C usb
# Load USB storage module if needed
sudo modprobe usb-storage
# Check file system on USB device
sudo fsck /dev/sdX1   # Replace sdX1 with actual device identifier
# Mount the USB device manually
sudo mount /dev/sdX1 /mnt   # Replace sdX1 with actual device identifier
# Reboot the system
sudo reboot 

# 25. Forgot login password
# Boot into recovery mode from GRUB menu
# Drop to root shell prompt
# Remount root filesystem as read-write
mount -o remount,rw /
# Reset the password for the user
passwd <username>
# Reboot the system
reboot  

# 26. Linux Performance problems
uptime              # Check system load average 
dmesg -T | tail     # Check for kernel errors
vmstat 1            # Overall stats by 1 second
mpstat -P ALL 1     # CPU usage by all cores
pidstat 1           # Per process stats by 1 second
iostat -xz 1        # Disk I/O stats by 1 second
free -m             # Memory usage
sar -n DEV 1        # Network stats by 1 second
sar -n TCP,ETCP 1   # TCP stats by 1 second
df -h               # Disk space usage
top                 # Interactive process viewer
atop                # Alternative interactive process viewer
htop                # Another interactive process viewer
strace -p <pid>     # Trace system calls of a process (Do NOT use on production systems without proper analysis)
perf top            # Real-time performance monitoring
perf record -F 99 -a -g -- sleep 10  # Record performance data for 10 seconds
perf report -n --stdio    # Analyze recorded performance data