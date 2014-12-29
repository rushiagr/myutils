function ifc () {
    IFACES=$(ifconfig -s | tail -n +2 | awk '{print $1}')
    for IF in $IFACES; do
        echo -e $IF '\t'  $(ifconfig $IF | grep 'inet addr' | awk '{print $2}' | cut -d: -f2)
    done
}

