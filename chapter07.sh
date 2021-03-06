#!/bin/bash
PkgUserDir=/usr/src/core
chgrp install /etc/sysconfig
chmod g+w,o+t /etc/sysconfig

lfs-btscrpts_ () {
Name=lfs-btscrpts
Pkg=lfs-btscrpts
install -v -d ${PkgUserDir}/${Name}
touch ${PkgUserDir}/${Name}/build
cat >> ${PkgUserDir}/${Name}/build << "IPS"
set +h
Pkg=$LOGNAME
Name=lfs-btscrpts
sourcedir=/sources/BOOK
unpack () {
cp ${sourcedir}/lfs-bootscripts-*z* .
cd `tar vxf lfs-bootscripts-*z* | awk -F\/ 'END{print $1}'`
}
unpack
make install
cd ..
for f in *.tar.*
do
  cdfile="${f%.tar*}"
done
rm -rf $cdfile
touch ~/.${Name}
IPS
installpkg $Pkg 
su $Pkg
}
lfs-btscrpts_
#
bash /lib/udev/init-net-rules.sh
cat /etc/udev/rules.d/70-persistent-net.rules
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
echo "gt70-dom" > /etc/hostname
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1   localhost
127.0.1.1   gt70-dom

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# End /etc/hosts
EOF
cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock, 
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF
cat > /etc/profile << "EOF"
# Begin /etc/profile

export LANG=en_US.UTF-8

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
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type   options         dump  fsck
#                                                        order
/dev/sdb3          /         ext4     defaults            1     1
/dev/sdb2          /boot     ext4     defaults            1     2
/dev/sdb4          /home     ext4     defaults            0     0
/dev/sdb5          /opt      ext4     defaults            0     0
/dev/sdb1          swap      swap     pri=1               0     0
proc               /proc     proc     nosuid,noexec,nodev 0     0
sysfs              /sys      sysfs    nosuid,noexec,nodev 0     0
devpts             /dev/pts  devpts   gid=5,mode=620      0     0
tmpfs              /run      tmpfs    defaults            0     0
devtmpfs           /dev      devtmpfs mode=0755,nosuid    0     0

# End /etc/fstab
EOF
#make subdirs of rc.d install dirs
chgrp install /etc/rc.d/*
chmod g+w,o+t /etc/rc.d/*
echo "Now run chapter08.sh and then install the kernel"
