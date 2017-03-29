#! /bin/bash

# Use locally cached APT packages. Currently supports local file server running
# on port 80 only. Also, only works when eth1 NIC is present

function xsources() {
    sudo cp /etc/apt/sources.list{,.backup}
    sudo rm /etc/apt/sources.list
    sudo bash -c "cat > /etc/apt/sources.list <<EOF
deb http://mc_ip/ubuntu trusty main restricted universe multiverse
deb http://mc_ip/ubuntu trusty-security main restricted universe multiverse
deb http://mc_ip/ubuntu trusty-updates main restricted universe multiverse
deb http://mc_ip/ubuntu trusty-proposed main restricted universe multiverse
deb http://mc_ip/ubuntu trusty-backports main restricted universe multiverse
EOF"
    
    #TODO(rushiagr): error out when no eth1 IP present
    ETH1_IP=$(ifconfig | grep eth1 -A 1 | tail -1 | cut -d ':' -f2- | cut -d ' ' -f1)
    ETH1_GW=$(echo $ETH1_IP | cut -d '.' -f1,2,3).1
    sudo sed -i s/mc_ip/$ETH1_GW/g /etc/apt/sources.list
}
