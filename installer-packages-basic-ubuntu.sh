#!/bin/bash -e

# Current Directory
CURRENT_DIR=$(pwd)

# Check Privileges
if [[ $UID -ne 0 ]]; then
  echo "Administrator Privilege Needed. Please run as An Administrator/Root User!"
  exit 1
fi

# Header Function
function printHeader() {
  clear
  echo "=================================================="
  echo "Basic Automatic Installer Ubuntu Package"
  echo "Email: aas.suhendar@gmail.com"
  echo "--------------------------------------------------"
  echo ""
}

# Change Working Directory
printHeader;
echo "=================================================="
echo "==> Change Working Directory"
cd "$CURRENT_DIR"
echo "--------------------------------------------------"
sleep 2

printHeader;
echo "=================================================="
echo "==> Add Backport source"
echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list.d/backport.list
cat /etc/apt/sources.list.d/backport.list
echo "--------------------------------------------------"
sleep 2

# Update and dist-upgrade
printHeader
echo "=================================================="
echo "==> Update and Dist Upgrade"
apt-get update 
apt-get dist-upgrade -y
echo "--------------------------------------------------"
sleep 2

# Install Packages
printHeader
echo "=================================================="
echo "==> Install Packages"
apt-get -y install bash bash-completion
apt-get -y install ca-certificates tzdata
apt-get -y install sudo sed grep byobu lsb-release
apt-get -y install curl wget rsync nano vim-tiny
apt-get -y install tar gzip bzip2 xz-utils p7zip-full zip unzip
apt-get -y install xfsprogs fdisk gdisk parted lvm2
apt-get -y install binutils util-linux logrotate
apt-get -y install dpkg dirmngr gnupg apt-transport-https software-properties-common
apt-get -y install htop iftop iotop sysstat nmon
apt-get -y install net-tools socat dnsutils bridge-utils
apt-get -y install inetutils-traceroute inetutils-ping openssh-client
echo "--------------------------------------------------"
sleep 2

# Clean Up Packages
printHeader
echo "=================================================="
echo "==> Clean Up Packages"
apt-get autoremove -y --purge
apt-get clean -y
echo "--------------------------------------------------"
sleep 2

# Completed
printHeader
echo "=================================================="
echo "Done, Completed!"
echo "--------------------------------------------------"
sleep 2
