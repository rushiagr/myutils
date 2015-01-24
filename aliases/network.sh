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
    if [ -z $1 ]; then
        ETH_IFS=$(ifconfig | grep ^eth | awk '{print $1}')
        for i in $ETH_IFS; do
            sudo ifdown $i
            sudo ifup $i
        done
        return
    fi
    sudo ifdown $1 && sudo ifup $1
}

alias ips='sudo iptables -S'
alias ipstn='sudo iptables -S -t nat'

function setproxy() {
    if [ -z $1 ]; then
        echo "Usage: setproxy <IP>"
        return
    fi
    export http_proxy=http://$1:3128
    export https_proxy=https://$1:3128

    NO_PROXY=localhost,127.0.0.1
    ETH_INTERFACES=$(ifconfig | grep ^eth | cut -d ' ' -f 1)
    for IF in $ETH_INTERFACES; do
        LOCAL_ETH_IP=$(ifconfig $IF | head -2 | tail -1 | grep "inet addr" \
            | cut -d ':' -f 2 | cut -d ' ' -f 1)
        if [ -z $LOCAL_ETH_IP ]; then
            continue
        else
            NO_PROXY+=,$LOCAL_ETH_IP
        fi
    done
    echo $NO_PROXY is no proxy
    export no_proxy=$NO_PROXY
}
