export LFS=/mnt/lfs
if [ ! -d $LFS ]; then
  mkdir -pv $LFS
fi
mount -v -t ext4 /dev/sda8 $LFS
if [ ! -d $LFS/boot ]; then
  mkdir -pv $LFS/boot
fi
mount -v -t ext4 /dev/sda6 $LFS/boot
if [ ! -d $LFS/home ]; then
  mkdir -pv $LFS/home
fi
mount -v -t ext4 /dev/sda7 $LFS/home
/sbin/swapon -v /dev/sda9
