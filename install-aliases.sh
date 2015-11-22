#! /bin/bash -eu

# Script which sets everthing up in a system

function sedeasy {
    if [ $(uname) == "Darwin" ]; then
          sed -i "" "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
      else
        sed -i "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
    fi
}

BASHRC_FILE="$HOME/.bash_history"


if [ $(uname) == "Darwin" ]; then
    if [ $(brew list | grep -c coreutils) == "0" ]; then
        echo "'coreutils' brew package not installed. Installing now..."
        brew install coreutils
    fi
    CURR_FILE_PATH=$(greadlink -f $0)
else
    CURR_FILE_PATH=$(readlink -f $0)
fi
MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | rev | cut -d'/' -f2- | rev)
VPN_CONF_PATH=${MYUTILS_DIR_PATH}/etc/vpn.conf

cat ${MYUTILS_DIR_PATH}/aliases/* >  $HOME/.aliasrc
sedeasy "__VPN_CONF_PATH__" $VPN_CONF_PATH $HOME/.aliasrc

export IS_BASHRC_EDITED=$(cat $BASHRC_FILE | grep -c "source $HOME/.aliasrc")

if [ $IS_BASHRC_EDITED -eq 0 ]; then
    echo "source $HOME/.aliasrc" >> $BASHRC_FILE
fi

DOTFILES=$(ls -a $MYUTILS_DIR_PATH/dotfiles | grep ^\\.[a-zA-Z])

TEMPDIR=""
for DOTFILE in $DOTFILES; do
    if [ -f $HOME/${DOTFILE} ]; then
        if [ "${TEMPDIR}" == "" ]; then
            TEMPDIR=$(mktemp -d)
        fi
        mv $HOME/$DOTFILE $TEMPDIR
    fi

    if [ $(uname) == "Darwin" ]; then
        gcp --recursive $MYUTILS_DIR_PATH/dotfiles/$DOTFILE $HOME
    else
        cp --recursive $MYUTILS_DIR_PATH/dotfiles/$DOTFILE $HOME
    fi
done

echo "Install successful."
echo "Aliases will be sourced from the next new shell session. To source them in the current session, do"
echo "    source ~/.aliasrc"

if [ "${TEMPDIR}" != "" ]; then
    echo -e "\nThe following existing dotfiles are moved to temp dir $TEMPDIR:"
    echo $(ls -a $TEMPDIR | grep ^\\.[a-zA-Z])
fi
