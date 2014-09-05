#! /bin/bash -e

# Script which sets everthing up in a system

function sedeasy {
      sed -i "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
}

CURR_FILE_PATH=$(readlink -f $0)
MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | rev | cut -d'/' -f2- | rev)
VPN_CONF_PATH=${MYUTILS_DIR_PATH}/etc/vpn.conf

cat ${MYUTILS_DIR_PATH}/aliasrc.template ${MYUTILS_DIR_PATH}/aliases/* >  ~/.aliasrc
sedeasy "__VPN_CONF_PATH__" $VPN_CONF_PATH ~/.aliasrc

export IS_BASHRC_EDITED=$(cat ~/.bashrc | grep -c "source ~/.aliasrc")

if [ $IS_BASHRC_EDITED -eq 0 ]; then
    echo "source ~/.aliasrc" >> ~/.bashrc
fi

DOTFILES=$(ls -a $MYUTILS_DIR_PATH/dotfiles | grep ^\\.[a-zA-Z])

for DOTFILE in $DOTFILES; do
    if [ -f ~/${DOTFILE} ]; then
        if [ "${TEMPDIR}" == "" ]; then
            TEMPDIR=$(mktemp -d)
        fi
        mv ~/$DOTFILE $TEMPDIR
    fi
    cp $MYUTILS_DIR_PATH/dotfiles/$DOTFILE ~
done

echo "Install successful."
echo "Aliases will be sourced from the next new shell session. To source them in the current session, do"
echo "    source ~/.aliasrc"

if [ "${TEMPDIR}" != "" ]; then
    echo -e "\nThe following existing dotfiles are moved to temp dir $TEMPDIR:"
    echo $(ls -a $TEMPDIR | grep ^\\.[a-zA-Z])
fi
