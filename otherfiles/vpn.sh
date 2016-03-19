vpn () {
    USER=rushi.agrawal
    VPNIP=49.40.3.252
    ROUTES=10.135.0.0,10.204.0.0,10.140.0.0

    IFS=","

    GATEWAY=$(route -n | grep "^0.0.0.0" | awk '{print $2}')

    connected=`ps aux | grep openconnect | grep vpnc | wc -l`

    if [ $connected -eq 0 ]; then
        sudo openconnect -b -u $USER -s /etc/vpnc/vpnc-script $VPNIP
        sudo route del -net 0.0.0.0 netmask 0.0.0.0 dev tun0
        sudo route add default gw $GATEWAY
        for ROUTE in $ROUTES; do
            sudo route add -net $ROUTE/16 dev tun0
        done
    else
        echo "Seems a VPN connection is already established. Exiting.."
    fi
    unset IFS
}
