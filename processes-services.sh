# Bash commands to manage processes and services
# Troubleshooting and managing system services and processes
# ps, awk, sed, systemctl, kill, grep, pgrep, pkill, top, htop
# ps: process status
# systemctl: control the systemd system and service manager
# kill: terminate processes
# pgrep/pkill: search/terminate processes by name
# top/htop: real-time process monitoring
# awk: text processing and data extraction
# sed: stream editor for filtering and transforming text

#####################################################
# PROCESS MANAGEMENT COMMANDS
# List all running processes
ps aux

# Find a specific process by name
pgrep -fl <process_name>

# Kill a process by name
pkill <process_name>

# Kill a process by PID
kill <PID>

# Display real-time system processes
top

# the ps command with filtering and formatting
ps aux | awk '{print $1, $2, $11}'                # User, PID, Command
ps aux | awk '{print $1, $2, $3, $11}'            # User, PID, %CPU, Command
ps aux | awk '{print $1, $2, $4, $11}'            # User, PID, %MEM, Command

# sort by memory
# Top 10 memory-consuming processes
ps aux --sort=-%mem | head -n 10                  
ps aux --sort=-%mem | awk '{print $1, $2, $4, $11}' | head -n 10

# sort by CPU
# Top 10 CPU-consuming processes
ps aux --sort=-%cpu | head -n 10                  
ps aux --sort=-%cpu | awk '{print $1, $2, $3, $11}' | head -n 10

# sed command to filter process list
# Example: Find processes related to "apache"
ps aux | sed -n '/apache/p'

# sed command to exclude certain processes
# Example: Exclude processes related to "ssh"
ps aux | sed '/ssh/d'

# sed command options
# -n : suppress automatic printing
# p  : print lines that match the pattern
# d  : delete lines that match the pattern

### top and htop commands
# Start top command
top

# Start htop command
htop

# top command keyboard shortcuts
# M - sort by memory usage
# P - sort by CPU usage
# k - kill a process (you will be prompted for PID)
# q - quit top

# htop command keyboard shortcuts
# F6 - sort by different columns
# F9 - kill a process (you will be prompted for signal type)
# sort by memory: F6 -> select MEM%
# sort by CPU: F6 -> select CPU%
# F10 - quit htop

# Create alises for frequently used commands
alias psmem="ps aux --sort=-%mem | head -n 10"
alias pscpu="ps aux --sort=-%cpu | head -n 10"
# Then you can use `psmem` and `pscpu` commands directly in the terminal


####################################################
# SERVICE MANAGEMENT COMMANDS

# Check all services and their statuses
systemctl list-units --type=service

# Check the status of a service
systemctl status <service_name>

# Start a service
systemctl start <service_name>

# Stop a service
systemctl stop <service_name>

# Restart a service
systemctl restart <service_name>
