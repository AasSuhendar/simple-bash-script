#!/bin/bash
# ZFS Installer Script on Debian
# Created by aas.suhendar@gmail.com

# Check Privileges
if [[ $UID -ne 0 ]]; then
  echo "Administrator Privilege Needed. Please run as An Administrator/Root User!"
  exit 1
fi

goReboot(){
	echo -n "are you sure to reboot now ? (y/n) : "
	read -re ans
	if [ "$ans" = Y ] || [ "$ans" = y ]
	then
		echo "Host Rebooted"
        sleep 2
		reboot
		exit 0
	fi
}


setupAPT(){
	echo "=================================================="
	echo "==> Add Backport source"
	echo "deb http://deb.debian.org/debian buster-backports main contrib" >> /etc/apt/sources.list.d/backport.list
	cat /etc/apt/sources.list.d/backport.list
	echo "--------------------------------------------------"

	echo "=================================================="
	echo "==> Prioritize the backports repository to always supply the latest ZFS packages"
	cat <<- EOF >> /etc/apt/preferences.d/90_zfs
	Package: libnvpair1linux libuutil1linux libzfs2linux libzpool2linux spl-dkms zfs-dkms zfs-test zfsutils-linux zfsutils-linux-dev zfs-zed
	Pin: release n=buster-backports
	Pin-Priority: 990
	EOF
	cat /etc/apt/preferences.d/90_zfs
	echo "--------------------------------------------------"

	echo "=================================================="
	echo "==> Upgrading OS & Installing Required Packages"
	apt-get update
	apt-get -y dist-upgrade
	apt-get -y install wget nano tar gzip
	apt-get -y purge --autoremove
	apt-get -y clean
	echo "--------------------------------------------------"


	echo "=================================================="
	echo "==> Reboot"
	goReboot
}

setupZFS(){
	apt-get -y install dpkg-dev linux-headers-"$(uname -r)"
	apt-get -y install zfs-dkms zfsutils-linux
}

if [ -z "$1" ]; then
  echo "Parameter Execute Not Found. Please execute with pattern ==> shell.sh [param]"
  echo "Available Params:"
  echo "APT - for Installed Backport Debian"
  echo "ZFS - for Installed ZFS Package"
  exit 0
fi

if [ "$1" = "APT" ]; then
	setupAPT;
elif [ "$1" = "ZFS" ]; then
	setupZFS;
fi