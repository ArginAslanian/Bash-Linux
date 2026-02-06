# All about linux logs/troubleshooting logs.

# Core system + boot logs:
# /var/log/syslog (Debian/Ubuntu) —             general system log.
# /var/log/messages (RHEL-ish) —                general system log.
# /var/log/kern.log —                           kernel messages (Debian/Ubuntu).
# /var/log/dmesg —                              boot-time kernel ring buffer snapshot (sometimes present).
# /var/log/boot.log —                           boot service messages (sometimes).

# Authentication/ssh/sudo logs:
# /var/log/auth.log (Debian/Ubuntu) —           auth, sudo, sshd activity.
# /var/log/secure (RHEL-ish) —                  auth log equivalent.
# /var/log/faillog —                            failed login tracking (tooling reads it).
# /var/log/wtmp —                               login history (use last).
# /var/log/btmp —                               failed logins (use lastb, root).
# /var/log/lastlog —                            last login per user.

# Scheduled jobs:
# /var/log/cron (RHEL-ish) —                    cron logs.
# var/log/syslog -                              cron logs on Debian/Ubuntu.

# Networking/Firewall logs:
# /var/log/ufw.log —                           UFW firewall logs (Ubuntu).
# /var/log/firewalld —                         firewalld logs (RHEL-ish, if enabled).
# /var/log/messages or /var/log/syslog —        firewall logs may also appear here.
# /var/log/audit/audit.log —                    SELinux/auditd logs (RHEL-ish).

# Package management + Updates:
# /var/log/apt/history.log, /var/log/apt/term.log —     package install history (Debian/Ubuntu).
# /var/log/dpkg.log —                               dpkg package actions (Debian/Ubuntu).
# /var/log/yum.log or /var/log/dnf.log —            package history (RHEL-ish).
# /var/log/dnf.log —                                   dnf history (RHEL-ish).

# Web servers:
# /var/log/nginx/access.log, /var/log/nginx/error.log
# /var/log/apache2/access.log, /var/log/apache2/error.log (Debian/Ubuntu)
# /var/log/httpd/access_log, /var/log/httpd/error_log (RHEL-ish)

# Common troubleshooting logs:
# Service won't start / Keeps restarting:
journalctl -u <service-name> --no-pager # -u shows logs for a specific systemd service.
# or check /var/log/syslog or /var/log/messages for related errors.

# SSH login issues:
# Check /var/log/auth.log (Debian/Ubuntu) or /var/log/secure (RHEL-ish) for sshd errors.
# Look for "Failed password" or "Accepted password" entries to diagnose login problems.

# High CPU/memory usage:
# Check /var/log/syslog or /var/log/messages for OOM killer activity or related errors.
# Use top/htop to identify resource-hungry processes.

# Disk space issues:
# Check /var/log/syslog or /var/log/messages for "No space left on device" errors.
# Use df -h to check disk usage and du -sh /* to find large directories.

# Network connectivity problems:
# Check /var/log/syslog or /var/log/messages for network-related errors.
# Use ping, traceroute, and netstat to diagnose network issues.

# Reboots/crashes:
# Check /var/log/syslog, /var/log/messages, and /var/log/kern.log for crash reports or OOM killer activity.
# Use dmesg to check for kernel messages related to hardware issues or crashes.

# Who logged in and when and last:
# Use last to see login history from /var/log/wtmp.
# Use lastb to see failed login attempts from /var/log/btmp (requires root).
# Use lastlog to see the last login time for each user from /var/log/lastlog.

# Kernel/hardware issues:
# Check /var/log/kern.log
# Check /var/log/dmesg for boot-time hardware/kernel messages.
dmesg | less
dmesg | grep -i error
journalctl -k --no-pager # -k shows only kernel messages from the journal.

# Firewall issues:
# Check /var/log/ufw.log for UFW logs (Ubuntu).
# Check /var/log/firewalld for firewalld logs (RHEL-ish).
# Check /var/log/syslog or /var/log/messages for firewall-related errors.
journalctl -u firewalld --no-pager # Check firewalld logs

# What changed recently:
# Check package manager logs for recent installs/updates.
# Check /var/log/apt/history.log or /var/log/dpkg.log (Debian/Ubuntu).
# Check /var/log/yum.log or /var/log/dnf.log (RHEL-ish).
# Check /var/log/syslog or /var/log/messages for recent errors or changes.

#####################################################
#####################################################
# Tips for searching for things in logs:
# 1. Use grep to filter logs for specific keywords. Example: grep -i error /var/log/syslog
# 2. Use less for easier navigation of large log files. Example: less /var/log/syslog
# 3. Use journalctl for systemd logs, which can be more structured and easier to search. Example: journalctl -u sshd --no-pager
# 4. Check timestamps to correlate events across different logs.
# 5. Look for patterns or repeated errors that might indicate the root cause of an issue.
# 6. tail -f can be used to monitor logs in real-time while reproducing an issue. Example: tail -f /var/log/syslog
# 7. grep -E "error|fail|warn" /var/log/syslog to find common error keywords in one go.
# 8. zgrep can be used to search through compressed log files (e.g., older rotated logs). Example: zgrep -i error /var/log/syslog.1.gz
# 9. Use log analyzers or visualization tools for large log sets to identify trends or anomalies.