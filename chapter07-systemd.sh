#!/bin/bash
cat > /etc/resolv.conf << "EOF"
# Generated by dhcpcd from wlan0
# /etc/resolv.conf.head can replace this line
domain hsd1.tx.comcast.net.
nameserver 68.87.85.98
nameserver 68.87.69.146
nameserver 75.75.76.76
# /etc/resolv.conf.tail can replace this line
# End /etc/resolv.conf
EOF
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1   localhost
127.0.1.1   W510

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# End /etc/hosts
EOF
echo "W510" > /etc/hostname
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=0

# Set this to any options you might need to give to hwclock, 
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF
cat > /etc/locale.conf << "EOF"
# Begin /etc/profile

export LANG=en_US.ISO-8859-1

# End /etc/profile
EOF
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type   options         dump  fsck
#                                                        order
/dev/sda8          /         ext4     defaults            1     1
/dev/sda6          /boot     ext4     defaults            1     2
/dev/sda7          /home     ext4     defaults            0     0
/dev/sda9          swap      swap     pri=1               0     0
proc               /proc     proc     nosuid,noexec,nodev 0     0
sysfs              /sys      sysfs    nosuid,noexec,nodev 0     0
devpts             /dev/pts  devpts   gid=5,mode=620      0     0
tmpfs              /run      tmpfs    defaults            0     0
devtmpfs           /dev      devtmpfs mode=0755,nosuid    0     0

# End /etc/fstab
EOF
echo "Now run chapter08.sh and install the kernel"
