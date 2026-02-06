# Linux directories and what they are used for

# / - root directory, the top-level directory of the filesystem
# /backup - commonly used for backup files (not standard; convention)
# /bin - contains essential binary executables
# /boot - contains files needed to boot the system
# /data - commonly used for data storage (not standard; convention)
# /dev - contains device files
# /efi - sometimes used as a UEFI/ESP mount point (often /boot/efi instead)
# /etc - contains system configuration files
# /home - contains user home directories
# /lib - contains shared libraries needed by programs
# /logs - commonly used for log files (uncommon; typically /var/log)
# /lost+found - contains recovered files after a filesystem check (filesystem-specific)
# /media - contains mount points for removable media
# /mnt - contains mount points for temporary/manual mounts
# /opt - contains optional/third-party software packages
# /proc - contains virtual files exposing kernel and process information
# /root - home directory for the root user
# /run - contains runtime (volatile) data for processes and services since boot
# /share - commonly used for shared data (not standard; convention)
# /snap - contains snap packages and their data (snap-enabled systems)
# /srv - contains data for services provided by the system
# /storage - commonly used for data storage (not standard; convention)
# /sys - contains virtual files exposing devices/drivers and kernel interfaces
# /tmp - contains temporary files
# /usr - contains most userland applications, libraries, and shared data
# /var - contains variable data like logs, caches, spools, and databases


################################################################
################################################################
## IMPORTANT FILES IN LINUX ADMINISTRATION
################################################################
# /etc - Identity, auth, sudo
# /etc/passwd — local user accounts (name, UID, home, shell).
# /etc/shadow — password hashes + password aging (root-readable).
# /etc/group — local groups.
# /etc/gshadow — group passwords/admins (root-readable).
# /etc/sudoers — sudo policy (use visudo).
# /etc/sudoers.d/* — drop-in sudo rules (best practice).
# /etc/login.defs — defaults for useradd/password aging.
# /etc/security/limits.conf — ulimits (nofile, nproc, etc.).
# /etc/security/limits.d/* — ulimit drop-ins.
# /etc/pam.d/* — PAM auth stack (sudo/login/sshd).

# /etc - Networking
# /etc/hostname — system hostname.
# /etc/hosts — static host mappings (quick DNS override).
# /etc/resolv.conf — DNS resolvers (often managed by systemd-resolved/NetworkManager).
# /etc/nsswitch.conf — lookup order (files/dns/ldap/etc.).
# /etc/services — well-known port/service names (reference).
# /etc/networks — legacy network names (rarely used).
# /etc/hosts.allow, /etc/hosts.deny — TCP wrappers (legacy; still seen).

# /etc - ssh
# /etc/ssh/sshd_config — SSH server settings (auth methods, allowed users, etc.).
# /etc/ssh/ssh_config — SSH client defaults.
# /etc/ssh/ssh_host_* — server host keys (identity of the machine).

# /etc - Time, locale, OS
# /etc/timezone (Debian/Ubuntu) — timezone string.
# /etc/localtime — timezone data file (often a symlink).
# /etc/locale.conf (RHEL-ish) / /etc/default/locale (Debian/Ubuntu) — locale settings.
# /etc/os-release — distro identification (super common in scripts).
# /etc/fstab — what filesystems mount at boot.
# /etc/crypttab — encrypted volumes mapping (when used).

# /etc - systemd + services (modern Linux)
# /etc/systemd/system/*.service — local/override service unit files.
# /etc/systemd/system/*.wants/ — enabled units (symlinks).
# /etc/systemd/journald.conf — journald behavior (storage, size).
# /etc/systemd/logind.conf — sessions, lid switch, etc.
# /etc/systemd/timesyncd.conf — NTP client settings (if using timesyncd).
# /etc/default/* — environment/defaults for services on Debian-ish systems.

# /etc - Scheduling
# /etc/crontab — system-wide cron.
# /etc/cron.d/* — cron drop-ins.
# /etc/cron.daily, /etc/cron.weekly, /etc/cron.monthly — periodic jobs.
# /etc/anacrontab — “run missed jobs” scheduling (if installed).

# /etc - Logging configuration
# /etc/rsyslog.conf, /etc/rsyslog.d/* — rsyslog rules (if using rsyslog).
# /etc/logrotate.conf, /etc/logrotate.d/* — log rotation (critical on servers).

# /etc - Packages & repositories
# Debian/Ubuntu
# /etc/apt/sources.list — APT repos.
# /etc/apt/sources.list.d/*.list — repo drop-ins.
# /etc/apt/apt.conf, /etc/apt/apt.conf.d/* — apt behavior.

# RHEL/CentOS/Fedora
# /etc/yum.conf — yum config (legacy).
# /etc/dnf/dnf.conf — dnf config.
# /etc/yum.repos.d/*.repo — repo definitions.

# /etc - Kernel / boot parameters
# /etc/sysctl.conf, /etc/sysctl.d/* — kernel tunables (IP forwarding, etc.).
# /etc/modprobe.conf (legacy), /etc/modprobe.d/* — kernel module options/blacklists.
# /etc/modules or /etc/modules-load.d/* — modules to load at boot.

# /etc - Storage rules
# /etc/udev/rules.d/* — device naming/permissions rules.

# /etc - Firewalls & security (varies by distro)
# /etc/ufw/* — UFW firewall config (Ubuntu common).
# /etc/firewalld/* — firewalld zones/services (RHEL common).
# /etc/selinux/config — SELinux mode (RHEL-ish).
# /etc/apparmor/* — AppArmor profiles (Ubuntu common).

# /etc - Web / reverse proxy / common daemons (if installed)
# /etc/nginx/nginx.conf, /etc/nginx/sites-available/*, sites-enabled/*
# /etc/apache2/apache2.conf, /etc/apache2/sites-available/*, sites-enabled/* (Debian/Ubuntu)
# /etc/httpd/conf/httpd.conf (RHEL-ish Apache)
# /etc/docker/daemon.json
# /etc/postfix/main.cf
# /etc/mysql/my.cnf or /etc/my.cnf
# /etc/redis/redis.conf
# /etc/samba/smb.conf

# /var/log - important log files
# /var/log/syslog (Debian/Ubuntu) —             general system log.
# /var/log/messages (RHEL-ish) —                general system log.
# /var/log/auth.log (Debian/Ubuntu) —           auth, sudo, sshd activity.
# /var/log/secure (RHEL-ish) —                  auth log equivalent.
# /var/log/kern.log —                           kernel messages (Debian/Ubuntu).
# /var/log/dmesg —                              boot-time kernel ring buffer snapshot (sometimes present).
# /var/log/boot.log —                           boot service messages (sometimes).
# /var/log/journal/* —                          persistent systemd journal (if enabled).
# /var/log/faillog —                            failed login tracking (tooling reads it).
# /var/log/wtmp —                               login history (use last).
# /var/log/btmp —                               failed logins (use lastb, root).
# /var/log/lastlog —                            last login per user.
# /var/log/cron (RHEL-ish) —                    cron logs; or cron entries in syslog on Debian/Ubuntu.
# /var/log/apt/history.log, /var/log/apt/term.log —     package install history (Debian/Ubuntu).
# /var/log/dpkg.log —                           dpkg package actions (Debian/Ubuntu).
# /var/log/yum.log or /var/log/dnf.log —        package history (RHEL-ish).
# /var/log/nginx/access.log, /var/log/nginx/error.log
# /var/log/apache2/access.log, /var/log/apache2/error.log (Debian/Ubuntu)
# /var/log/httpd/access_log, /var/log/httpd/error_log (RHEL-ish)
# /var/log/mysql/error.log (or under /var/log/mariadb/)
# /var/log/docker.log (sometimes) / daemon logs usually in journal now.

# /procCPU, memory, OS, kernel
# /proc/cpuinfo — CPU model/flags/cores.
# /proc/meminfo — memory stats (RAM, cache, swap).
# /proc/loadavg — load average + runnable processes.
# /proc/uptime — uptime seconds.
# /proc/version — kernel version/build.
# /proc/cmdline — kernel boot parameters.
# /proc/modules — loaded kernel modules.
# /proc/partitions — block devices/partitions view.
# /proc/mounts — current mounts (like mount output).

# /sys — devices/drivers/kernel interfaces (virtual)
# /sys/class/net/<iface>/ — link state, MTU, device info.
# /sys/block/<disk>/ — disk queue settings, scheduler, stats.
# /sys/devices/ — device tree (PCI/USB devices).
# /sys/fs/cgroup/ — cgroup controls (resource limits; containers).
# /sys/kernel/ — kernel parameters/exposed knobs.

# /home and /root — user-level troubleshooting hotspots
# ~/.ssh/authorized_keys — SSH in with keys to ssh in without a password.
# ~/.ssh/config — per-user SSH settings.
# ~/.bashrc, ~/.profile — shell environment.
# ~/.bash_history — sometimes useful for “what changed?” (if not disabled).