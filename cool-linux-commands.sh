# A collection of cool linux commands that can be useful for various tasks.

########################################################################
duf # A modern disk usage utility that provides a more user-friendly interface than the traditional 'du' command.
duf --all
duf --only local
duf --sort size

########################################################################
rg # A fast and powerful alternative to 'grep' for searching through files.
# rg examples:
# Search for a specific string in a file:
rg "search_string" file.txt 
# Search for a specific string in all files in a directory:
rg "search_string" /path/to/directory
# Search for a specific string in all files with a specific extension:
rg "search_string" -g "*.log"
rg "search_string" -g "*.txt"
rg "search_string" --type py # search only python files (known types: c, cc, cpp, cs, css, go, h, html, java, js, json, md, php, py, rb, rs, sh, sql, xml)

########################################################################
lshw # A command that provides detailed information about the hardware components of a Linux system.

# lshw examples:
# Show detailed information about all hardware components:
lshw
# Show detailed information about a specific hardware component:
lshw -class network
# Show detailed information about a specific hardware component, including the configuration:
lshw -class network -short
# Show detailed information about a specific hardware component, including the configuration and capabilities:
lshw -class network -html
# Show detailed information about a specific hardware component, including the configuration and capabilities, in a human-readable format:
lshw -class network -json
# Show detailed information about a specific hardware component, including the configuration and capabilities, in a human-readable format, with a specific output format:
lshw -class network -json -quiet
# example hardware: cpu, memory, disk, network, display.
# can also use -C instead of -class for a shorter command:
lshw -C network

########################################################################
mtr # A network diagnostic tool that combines the functionality of 'traceroute' and 'ping' to provide real-time information about the route and latency of network packets.
# mtr examples:
# Show the route and latency to a specific host:
mtr example.com
# Show the route and latency to a specific host, with a specific number of pings:
mtr -c 10 example.com
# Show the route and latency to a specific host, with a specific interval between pings:
mtr -i 1 example.com
# wide output:
mtr -w example.com

########################################################################
ranger # A terminal-based file manager that provides a more user-friendly interface for navigating and managing files in the terminal.
# ranger examples:
# Open ranger in the current directory:
ranger
# Open ranger in a specific directory:
ranger /path/to/directory
# Open ranger with a specific file selected:
ranger /path/to/directory/file.txt

########################################################################
glances # A cross-platform system monitoring tool that provides real-time information about the system's performance, including CPU, memory, disk, network, and more.
# glances examples:
# Show real-time system performance information:
glances
glances -t 1
glances -w          # web server mode

########################################################################
iotop # A command-line utility that provides real-time information about the I/O performance of a Linux system, including disk read/write speeds, I/O wait times, and more.
# iotop examples:
# Show real-time I/O performance information:
iotop
# Show real-time I/O performance information, with a specific refresh rate:
iotop -d 1

########################################################################
stat # A command that provides detailed information about a file or directory, including its size, permissions, ownership, and more.
# stat examples:
# Show detailed information about a specific file:
stat file.txt
# Show detailed information about a specific directory:
stat /path/to/directory
# stat -f can be used to show information about the filesystem instead of a specific file or directory:
stat -f /path/to/directory

########################################################################
dstat # system resource stats.
# dstat examples:
# Run dstat by itself:
dstat
# Show only network information:
dstat -n
# Show only CPU information:
dstat -c
# Show only disk information:
dstat -d
# Show only memory information:
dstat -m
# Show only I/O information:
dstat -i
# Show only process information:
dstat -p
# Show only system information:
dstat -s
# Show only network information, with a specific refresh rate:
dstat -n -d 1
# Show only CPU information, with a specific refresh rate:
dstat -c -d 1
# Show only network and cpu information, with a specific refresh rate:
dstat -n -c -d 1

########################################################################
termshark # A terminal-based network protocol analyzer that provides a more user-friendly interface for analyzing network traffic in the terminal.
# termshark examples:
# Capture and analyze network traffic in real-time:
termshark
# Capture and analyze network traffic from a specific interface:
termshark -i eth0
# Capture and analyze network traffic from a specific interface, with a specific filter:
termshark -i eth0 -f "tcp port 80"
# Capture and analyze network traffic from a specific interface, with a specific filter, and save the captured traffic to a file:
termshark -i eth0 -f "tcp port 80" -w capture.pcap
# Analyze a previously captured traffic file:
termshark -r capture.pcap   

########################################################################
lsof -i # A command that lists open files and the processes that are using them, including network connections, files, and more.
# lsof -i examples:
# Show all open files and the processes that are using them:
lsof -i
# Show all open files and the processes that are using them, with a specific filter for network connections:
lsof -i tcp:80
# Show what process is using port 80
lsof -i :80

########################################################################
ipcalc # subnet calculator that provides information about IP addresses, subnet masks, and more.
# ipcalc examples:
# subnet calculator for a specific IP address and subnet mask:
ipcalc 192.168.1.0/24

########################################################################
procs # A command that provides detailed information about the processes running on a Linux system, including their CPU and memory usage, and more.
# procs examples:
# Show detailed information about all processes:
procs
# Show detailed information about all processes, with a specific refresh rate:
procs -d 1
# Show detailed information about all processes, with a specific output format:
procs -o pid,ppid,cmd,%cpu,%mem
# sort by cpu usage:
procs -o pid,ppid,cmd,%cpu,%mem --sortd cpu
# sort by memory usage:
procs -o pid,ppid,cmd,%cpu,%mem --sortd mem
# show in a tree format:
procs -o pid,ppid,cmd,%cpu,%mem --tree

########################################################################
shred # overwrite a file to hide its contents, and optionally delete it
# shred examples:
# Overwrite a specific file:
shred file.txt
# specific number of overwrites:
shred -n 5 file.txt
# delete after overwriting:
shred -u file.txt
# overwrite 3 times, then delete:
shred -n 3 -u file.txt
