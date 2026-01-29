# users management

# package managers
apt
yum
dnf
zypper
pacman
apk

# current user
whoami

# run as administrator
sudo 

# switch to root user
su -

# run as another user
su - username

# switch user
su - username

# add a new user
useradd username

# delete a user
userdel username

# modify a user
usermod options username

# change user password
passwd username

# display user information
id username

# list all users
cat /etc/passwd

# list all groups
cat /etc/group

# add a new group
groupadd groupname

# delete a group
groupdel groupname groupname

# modify a group
groupmod options groupname

# add user to a group
usermod -aG groupname username

# remove user from a group
gpasswd -d username groupname

# display logged in users
who

# display last logged in users
last

# display currently logged in users
w

# display user sessions
users

# change user ownership of a file
chown username:groupname filename