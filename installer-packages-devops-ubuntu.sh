#!/bin/bash

goExit(){
	echo -n "are you sure to exit ? (y/n) : "
	read -r ans
	if [ "$ans" = Y -o "$ans" = y ]
	then
		echo "Keep Learning. Thanks you."
        sleep 2
		clear
		exit
	fi
}

anyKey(){
	orig=$(stty -g);
	echo -e "Press any key to continue. \c";
	stty -echo;
	stty raw;
	any=$(dd if=/dev/tty bs=1 count=1 2>/dev/null);
	stty "$orig"	
}

# Check Privileges
if [[ $UID -ne 0 ]]; then
  echo "Administrator Privilege Needed. Please run as An Administrator/Root User!"
  exit 1
fi

# Header Function
function printHeader() {
  clear
  echo "=================================================="
  echo "Basic Installer Devops Package"
  echo "Email: aas.suhendar@gmail.com"
  echo "--------------------------------------------------"
  echo ""
}

# Install Ansible with Python PIP 
installAnsible(){
	printHeader
	echo "==> Installing Ansible"
	echo "=================================================="
    wget -q -O - https://bootstrap.pypa.io/get-pip.py | python3 -
    pip3 install --no-cache-dir --upgrade pip setuptools wheel
    pip3 install --no-cache-dir virtualenv ansible
    ansible --version
    echo "=================================================="
    echo "Done, Completed!"
}

installTerraform(){
	printHeader
	echo "==> Installing Terraform 0.12.26"
	echo "=================================================="
    rm -rf terraform_0.12.26_linux_amd64.zip
    wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
    unzip ./terraform_0.12.26_linux_amd64.zip -d /usr/local/bin
    /usr/local/bin/terraform version
    echo "=================================================="
    echo "Done, Completed!"
}

installDocker(){
    printHeader
	echo "==> Installing Docker"
	echo "=================================================="

  	apt-get install ca-certificates curl
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt-get update

    	apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
	    echo -e "You want add user to group docker ? [y/n]: \c"
	    read option
	    if [ $option = Y -o $option = y ]
	    then
	        echo -e "Username for add to group docker : \c"
	        read useradd
	        usermod -aG docker $useradd
	    fi
     
	docker info
	docker --version
	docker compose version
	echo "=================================================="
	echo "Done, Completed!"
}



while :
    do

    printHeader

    echo "Choose Package to Install"
    echo "+++++++++++++++++++++++++"
    echo "1. Install Ansible"
    echo "2. Install Terraform"
    echo "3. Install Docker"
    echo "0. Exit"

    echo -e "Your option [1-5] : \c"
    read -r option

    case $option in 
        1|[aA])installAnsible;;
        2|[tT])installTerraform;;
        3|[dD])installDocker;;
        0|[Ee])goExit;;
        *);;
    esac

    anyKey
done

