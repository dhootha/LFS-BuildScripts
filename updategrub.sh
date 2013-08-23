#!/bin/bash

export LFS=/mnt/lfs
bootdir=${LFS}/boot
GetvmVersion () {
# $1 is the name of the vmlinuz file
# $2 is the name to remove
# $3 is the name to trim against - SVN in this case
local vmFileName=$1
local remove=$2
local trim=$3
vmFileVers=""
vmExt="${vmFileName#*${remove}}"
vmFileVers="${vmExt%${trim}*}"
return 0
} # end GetvmVersion
#
ntor () {
local remove="simple-"
while read -r line
do
  case $line in
    *Linux-*)
       etitle=$( echo $line | awk '{print $2}' )
       etitle=${etitle#"'"} # remove the quotes
       etitle=${etitle%"'"}
       esda8=$( echo $line | awk '{print $10}' )
       esda8="${esda8#*${remove}}"
       esda8=${esda8%"'"}
    ;;
    *ahci0,gpt6*)
       esda6=$( echo $line | awk '{print $NF}' )
    ;;
    *vmlinuz-[0-9]*)
       evmlinuz=$( echo $line | awk '{print $2}' )
       evmlinuz=${evmlinuz#"/"} # remove the / at the beginning
    ;;
  esac
done < $grub_file
} # end ntor
#
uuid_sda8=$( blkid | grep sda8 | awk -F\" '{print $2}' )
uuid_sda6=$( blkid | grep sda6 | awk -F\" '{print $2}' )
grub_file="/boot/grub/grub.cfg"
ntor
echo "These strings - "
echo $etitle
echo $esda8
echo $esda6
echo $evmlinuz
echo "will be replaced by these - "
# update the file
sed -e "s/$esda8/$uuid_sda8/" \
    -e "s/$esda6/$uuid_sda6/g" \
    -i $grub_file
vmFile=$( ls -l $bootdir | grep vmlinuz | awk '{print $NF}' )
sed -e "s/$evmlinuz/$vmFile/" -i $grub_file
GetvmVersion $vmFile vmlinuz -SVN
title="Linux${vmFileVers}"
sed -e "s/$etitle/$title/" -i $grub_file
echo $title
echo $uuid_sda8
echo $uuid_sda6
echo $vmFile
