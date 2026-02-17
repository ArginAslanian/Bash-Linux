# App management commands on Debian-based systems

# Check for updates
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Get a list of all desktop applications
ls /usr/share/applications 

# Get a list of snap applications
ls /snap/bin

# To find a specific application, you can use which or whereis
which firefox
whereis firefox
which code
whereis code

# snap list
snap list

# flatpak list
flatpak list

# To install a new application using apt
sudo apt install <application-name>

# To install a new application using snap
sudo snap install <application-name>

# To install a new application using flatpak
flatpak install <application-name>

# To remove an application using apt
sudo apt remove <application-name>

# To remove an application using snap
sudo snap remove <application-name>

# To remove an application using flatpak
flatpak uninstall <application-name>

# To search for an application using apt
apt search <application-name>

# To search for an application using snap
snap find <application-name>

# To search for an application using flatpak
flatpak search <application-name>

# To get more information about an application using apt
apt show <application-name>

# To get more information about an application using snap
snap info <application-name>

# To get more information about an application using flatpak
flatpak info <application-name>
