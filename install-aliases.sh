#! /bin/bash

# Script which sets everthing up in a system

#TODO: Install aliasrc in the system by putting it in .bashrc, or something
# similar

CURR_FILE_PATH=$(readlink -f $0)
MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | cut -d'/' -f-3)
VPN_CONF_PATH=${MYUTILS_DIR_PATH}/etc/vpn.conf
sed -i s/__VPN_CONF_FILE__/VPN_CONF_PATH/g aliasrc
