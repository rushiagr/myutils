#! /bin/bash

# Script which sets everthing up in a system

function sedeasy {
      sed -i "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
}

CURR_FILE_PATH=$(readlink -f $0)
MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | cut -d'/' -f-4)
VPN_CONF_PATH=${MYUTILS_DIR_PATH}/etc/vpn.conf

cp ${MYUTILS_DIR_PATH}/aliasrc.template ~/.aliasrc
sedeasy "__VPN_CONF_PATH__" $VPN_CONF_PATH ~/.aliasrc

IS_BASHRC_EDITED=$(cat ~/.bashrc | grep -c "source ~/.aliasrc")

if [ $IS_BASHRC_EDITED -eq 0 ]; then
    echo "source ~/.aliasrc" >> ~/.bashrc
fi

echo "Install successful."
echo "Aliases will be sourced from the next new shell session. To source them in the current session, do"
echo "    source ~/.aliasrc"

