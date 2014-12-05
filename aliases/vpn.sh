export VPN_CONF_PATH=__VPN_CONF_PATH__

vpn () {
    if [ ! -e ${VPN_CONF_PATH} ]; then
        echo "No vpn.conf file found to fetch configuration from. Exiting.."
        return
    fi
    source $VPN_CONF_PATH

    IFS=","

    GATEWAY=$(route -n | grep "^0.0.0.0" | awk '{print $2}')

    connected=`ps aux | grep openconnect | grep vpnc | wc -l`

    if [ $connected -eq 0 ]; then
        sudo openconnect -b -u $USER -s /etc/vpnc/vpnc-script $VPNIP
        sudo route del -net 0.0.0.0 netmask 0.0.0.0 dev tun0
        sudo route add default gw $GATEWAY
        for ROUTE in $ROUTES; do
            sudo route add -net $ROUTE/24 dev tun0
        done
    else
        echo "Seems a VPN connection is already established. Exiting.."
    fi
}
