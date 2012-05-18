export LFS=/mnt/lfs
if [ ! -d $LFS/sources ]; then
  mkdir -v $LFS/sources
fi
chmod -v a+wt $LFS/sources
if [ ! -d $LFS/tools ]; then
  mkdir -v $LFS/tools
fi
ln -sv $LFS/tools /
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
