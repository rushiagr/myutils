#!/bin/bash

source vpnrc

IFS=","

if [ $# -eq 0 ]
then
	echo "usage: vpn.sh [h|o]"
    echo "   o stands for office, h for home"
	exit
fi

if [ $1 == "o" ]; then
    GATEWAY=$OFFICEGW
else
    GATEWAY=$HOMEGW
fi

connected=`ps aux | grep openconnect | grep vpnc | wc -l`

if [ $connected -eq 0 ]; then
    sudo openconnect -b -u $USER -s /etc/vpnc/vpnc-script $VPNIP
    sudo route del -net 0.0.0.0 netmask 0.0.0.0 dev tun0
    sudo route add default gw $GATEWAY
    for ROUTE in $ROUTES; do
        sudo route add -net $ROUTE/24 dev tun0
    done
fi
