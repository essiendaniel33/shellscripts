#!/bin/bash

# Author: info@ityourway.tech

# Description: Shell script to install a specific set of packages on CentOS and Ubuntu distributions

# Function to detect the Linux distribution
detect_distribution() {
    if [ -f /etc/centos-release ]; then
        echo "centos"
    elif [ -f /etc/lsb-release ]; then
        echo "ubuntu"
    else
        echo "unsupported"
    fi
}

# Function to install packages on CentOS
install_packages_centos() {
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum-config-manager --add-repo=https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io httpd firewalld net-tools git ntp htop wget zip vim java-1.8.0-openjdk-headless epel-release
    sudo yum install -y python3 ansible jq unzip
    sudo yum install -y terraform
    sudo yum install -y awscli
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

# Function to install packages on Ubuntu
install_packages_ubuntu() {
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    sudo add-apt-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y docker.io apache2 firewalld net-tools git ntp jq htop wget zip unzip vim openjdk-7-jre-headless python3 ansible
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update
    sudo apt-get install -y terraform
    sudo apt-get install -y awscli
    sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

# Main script
distribution=$(detect_distribution)

case $distribution in
    "centos") install_packages_centos ;;
    "ubuntu") install_packages_ubuntu ;;
    *) echo "Unsupported distribution." ;;
esac

