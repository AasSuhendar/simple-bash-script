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
cd $CURRENT_DIR
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
apt-get install -y bash bash-completion 
apt-get install -y ca-certificates tzdata
apt-get install -y sudo dpkg apt-transport-https openssh-client
apt-get install -y binutils dnsutils bridge-utils util-linux inetutils-traceroute net-tools
apt-get install -y curl wget grep sed rsync socat netcat htop nano
apt-get install -y tar gzip bzip2 xz-utils zip unzip
apt-get install -y build-essential
apt-get install -y python3 python3-dev
apt-get install -y git git-flow
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