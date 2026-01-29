# Bash for files viewing and editing

# view file content
cat

# view file content with pagination
less

# view file content with pagination (alternative)
more

# display first 10 lines of a file
head

# display last 10 lines of a file
tail

# edit a file with nano editor
nano

# edit a file with vim editor
vim

# search for a pattern in a file
grep

# count lines, words, and characters in a file
wc

# compare two files line by line
diff

# concatenate multiple files
cat file1 file2 > combined_file

# find files by name
find . -name "filename"

# find files by extension
find . -name "*.txt"

# change file permissions
chmod

# change file ownership
chown

# grant read, write, and execute permissions to the owner
chmod u+rwx filename

# grant read and write permissions to group
chmod g+rw filename

# grant read permission to others
chmod o+r filename

# view file permissions in long listing format
ls -l filename

# display disk usage of files and directories
du -h

# display free disk space
df -h

# create a symbolic link to a file
ln -s target_file link_name

# display file type
file filename

# archive files into a tarball
tar -cvf archive.tar file1 file2

# extract files from a tarball
tar -xvf archive.tar

# compress a file using gzip
gzip filename   

# decompress a gzip file
gunzip filename.gz

# compress a file using bzip2
bzip2 filename

# decompress a bzip2 file
bunzip2 filename.bz2

# compress a file using xz
xz filename

# decompress an xz file
unxz filename.xz    

# display inode number of a file
ls -i filename

# change file timestamps
touch -t YYYYMMDDhhmm.ss filename

# monitor file changes in real-time
tail -f filename

# find and replace text in a file using sed
sed -i 's/old_text/new_text/g' filename

# display file content with line numbers
nl filename

# Awk command to process and analyze text files
awk '{print $0}' filename

# Awk command to print specific column (e.g., 2nd column)
awk '{print $2}' filename

#############################################################
### common grep options
# case insensitive search: grep -i "pattern" filename
# search recursively in directories: grep -r "pattern" directory/
# display line numbers with matches: grep -n "pattern" filename
# count number of matches: grep -c "pattern" filename
# search for whole words only: grep -w "pattern" filename
# invert match (show lines that do not match): grep -v "pattern" filename
#############################################################

#############################################################
### vim editor shortcuts
# Open file: vim filename
# Save file: :w
# Exit vim: :q
# Save and exit vim: :wq
# Quit without saving: :q!
# insert mode: i
# command mode: Esc
# append mode: a
# open a new line below: o
# open a new line above: O
# Move cursor up: k
# Move cursor down: j
# Move cursor left: h
# Move cursor right: l
# Cut line: dd
# Paste line: p
# Search text: /pattern
# Search and replace: :%s/old/new/g
# Go to line number: :linenumber
#############################################################

#############################################################
### nano editor shortcuts
# Open file: nano filename
# Save file: Ctrl + O
# Exit nano: Ctrl + X
# Cut line: Ctrl + K
# Paste line: Ctrl + U
# Search text: Ctrl + W
# Search and replace: Ctrl + \
# Go to line number: Ctrl + _ (underscore)
#############################################################