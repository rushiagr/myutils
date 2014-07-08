#! /bin/bash -e

# usage: image-if.sh IMAGE IP
# Assign $IP to eth0 of IMAGE qcow2 image

#TODO: add check conditions: if two variables are not provided
#TODO: output that this image will now have this IP
#TODO: mount at a tempdir created by mktemp

mntq () {
    if [[ -z $1 ]]; then
        echo "  usage: mntq image-to-mount.qcow2 [/mountpoint]"
        kill -INT $$
    fi
    MNTPOINT=/mnt
    if [[ ! -z $2 ]]; then
        $MNTPOINT=$2;
    fi
    sudo modprobe nbd;
    sudo qemu-nbd -c /dev/nbd0 $1
    sudo mount /dev/nbd0p1 $MNTPOINT
}

umntq () {
    MNTPOINT=/mnt
    if [[ ! -z $1 ]]; then
        $MNTPOINT=$1;
    fi
    sudo umount $MNTPOINT
    sudo qemu-nbd -d /dev/nbd0
}

mntq $1

GATEWAY=`echo $2 | cut -d'.' -f1,2,3`
GATEWAY=$GATEWAY.1

cat > /mnt/etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
address $2
netmask 255.255.255.0
gateway $GATEWAY
EOF

echo "IP $2 successfully inserted into image `echo $1 | rev | cut -d'/' -f1 | rev`"

umntq > /dev/null
