#! /bin/bash -e

# NOTE: Only edits the files. Reboot required
# for effects to take place

if (( EUID != 0 )); then
    echo "Should run as root. Exiting.."
    exit 0
fi

if [[ -z $1 ]]; then
    echo "usage: change-hostname HOSTNAME"
    exit 0
fi

cp /etc/hostname /etc/hostname\.bak\.$RANDOM
cp /etc/hosts /etc/hosts\.bak\.$RANDOM

HOSTNAME=`hostname`

sed -i s/\ $HOSTNAME/\ $1/g /etc/hosts
sed -i s/$HOSTNAME/$1/g /etc/hostname

sudo hostname $HOSTNAME
