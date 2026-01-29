# Bash commands for network and system information

# Network Information
ifconfig -a               # Display all network interfaces and their configurations
netstat -rn               # Show the kernel routing table
ss -s                     # Display summary statistics for all protocols
ip addr show              # Display all IP addresses assigned to interfaces
ip route show             # Show the routing table
ss -tuln                  # List all listening TCP and UDP ports
ping -c 4 google.com      # Test connectivity to an external host
ssh user@hostname         # Connect to a remote host via SSH
dig example.com           # Perform DNS lookup for a domain
hostname                  # Display the current system's hostname

# Check network connectivity
traceroute google.com     # Trace the route packets take to a host
mtr google.com            # Network diagnostic tool combining ping and traceroute
curl -I http://example.com # Fetch HTTP headers from a URL
wget http://example.com/file.txt  # Download a file from a URL

# Check wifi status
iwconfig                  # Display wireless network interface information
nmcli dev status          # Show the status of network devices managed by NetworkManager
nmcli con show            # List all network connections
nmcli con up id "Connection_Name"   # Connect to a specific network connection
nmcli con down id "Connection_Name" # Disconnect from a specific network connection

# Check network card
etstat -i                 # Display network interfaces statistics
lshw -C network           # Show detailed information about network hardware

scp file.txt user@hostname:/path/to/destination  # Copy a file to a remote host
scp user@hostname:/path/to/file.txt ./          # Copy a file from a remote host to local system
scp -r /local/directory user@hostname:/remote/directory  # Recursively copy a directory to a remote host

# File Synchronization
rsync -avz source/ user@remote:/destination/  # Synchronize files between local and remote systems
rsync -avz user@remote:/source/ destination/  # Synchronize files from remote to local system
rsync -avz --delete source/ user@remote:/destination/  # Synchronize and delete files not present in source
rsync -avz --progress source/ user@remote:/destination/  # Synchronize with progress display
rsync -avz -e "ssh -p 2222" source/ user@remote:/destination/  # Synchronize over SSH on a custom port
rsync -avz --exclude='*.tmp' source/ user@remote:/destination/  # Synchronize while excluding certain files
rsync -avz --dry-run source/ user@remote:/destination/  # Perform a trial run without making changes

# System Information
uname -a                  # Display system information
df -h                     # Show disk space usage in human-readable format
free -h                   # Display memory usage in human-readable format
top -b -n 1               # Show current processes and system resource usage
uptime                    # Display system uptime and load averages
lscpu                     # Display CPU architecture information
lsblk                     # List information about block devices
dmidecode -t system       # Show system hardware information

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

crontab -l                # List all scheduled cron jobs for the current user
crontab -e                # Edit the cron jobs for the current user
crontab -r                # Remove all cron jobs for the current user
cronctl list-timers       # List all active systemd timers

# Disk Management
lsblk                       # List all block devices
fdisk -l                    # List all disk partitions
mount /dev/sdX1 /mnt        # Mount a partition to a directory
umount /mnt                 # Unmount a mounted partition
mkfs.ext4 /dev/sdX1         # Create an ext4 filesystem on a partition
parted /dev/sdX             # Start parted to manage disk partitions
top -b -n 1                 # Show current processes and system resource usage
htop                        # Interactive process viewer
ps aux                      # Display all running processes
kill <PID>                  # Terminate a process by its PID
killall <process_name>      # Terminate all processes with the given name
df -h                       # Show disk space usage in human-readable format
du -sh /path/to/directory   # Show the size of a directory
uptime                      # Display system uptime and load averages