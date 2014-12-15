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

# net-route forwards network from one interface to another. net-unroute will
# remove the forwarding

net-route() {
    # TODO(rushiagr): enable sysctl ipv4 forwarding rule automatically if it is
    # not present
    if [ -z $1 -o -z $2 ]; then
        echo "  usage: net-route FROM-IF TO-IF"
        kill -INT $$
    fi
    sudo iptables --append POSTROUTING --table nat --out-interface $1 --jump MASQUERADE
    sudo iptables --append FORWARD --in-interface $2 --out-interface $1 --match state --state RELATED,ESTABLISHED --jump ACCEPT
}

net-unroute() {
    if [ -z $1 -o -z $2 ]; then
        echo "  usage: net-unroute FROM-IF TO-IF"
        kill -INT $$
    fi
    sudo iptables --delete POSTROUTING --table nat --out-interface $1 --jump MASQUERADE
    sudo iptables --delete FORWARD --in-interface $2 --out-interface $1 --match state --state RELATED,ESTABLISHED --jump ACCEPT
}

zresolvconf() {
    echo "nameserver 127.0.1.1" | sudo tee /etc/resolv.conf
}

function ifud() {
    sudo ifdown $1 && sudo ifup $1
}

alias ips='sudo iptables -S'
alias ipstn='sudo iptables -S -t nat'
