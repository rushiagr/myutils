function portroute-add() {
    # $1 - local port
    # $2 - VM IP
    # $3 - VM port
    sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport $1 -j DNAT --to-destination $2:$3
}

function portroute-del() {
    # $1 - local port
    # $2 - VM IP
    # $3 - VM port
    sudo iptables -t nat -D PREROUTING -p tcp -m tcp --dport $1 -j DNAT --to-destination $2:$3
}
