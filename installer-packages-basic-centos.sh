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
  echo "Basic Automatic Installer Centos Package"
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

# Update and dist-upgrade
printHeader
echo "=================================================="
echo "==> Update and Dist Upgrade"
yum update -y
yum upgrade -y
echo "--------------------------------------------------"
sleep 2

# Install Packages
printHeader
echo "=================================================="
echo "==> Install Packages"
yum install -y bash bash-completion 
yum install -y ca-certificates tzdata
yum install -y openssh-clients
yum install -y binutils bridge-utils util-linux net-tools
yum install -y curl wget grep sed rsync socat netcat htop nano
yum install -y tar gzip bzip2 zip unzip
yum install -y python3 python3-devel
yum install -y git
echo "--------------------------------------------------"
sleep 2

# Clean Up Packages
printHeader
echo "=================================================="
echo "==> Clean Up Packages"
yum clean packages -y
yum clean all -y
echo "--------------------------------------------------"
sleep 2

# Completed
printHeader
echo "=================================================="
echo "Done, Completed!"
echo "--------------------------------------------------"
sleep 2