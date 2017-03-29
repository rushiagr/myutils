#! /bin/bash -e

# This script creates ~/.aliasrc file by taking all the aliases and bash
# functions in the safe/ directory. It then adds a line to source ~/.aliasrc in
# system's bash profile file (~/.bashrc or ~/.bash_profile, depending upon if
# the OS is Mac OS or Ubuntu). Re-running this script multiple times doesn't
# add the same line in bash profile again and again.

BASHRC_FILE="$HOME/.bashrc"

if [ $(uname) == "Darwin" ]; then
    if [ $(brew list | grep -c coreutils) == "0" ]; then
        if [ $"{1}" != "--skip-install" ]; then
            echo "'coreutils' brew package not installed. Installing after 10 seconds. Press CTRL+c to abort, and rerun as 'install.sh --skip-install'"
            sleep 10
            brew install coreutils
        fi
    fi
    CURR_FILE_PATH=$(greadlink -f $0)
    BASHRC_FILE="$HOME/.bash_profile"
else
    CURR_FILE_PATH=$(readlink -f $0)
fi
MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | rev | cut -d'/' -f2- | rev)

cat ${MYUTILS_DIR_PATH}/safe/* >  $HOME/.aliasrc

export IS_BASHRC_EDITED=$(cat $BASHRC_FILE | grep -c "source $HOME/.aliasrc")

if [ $IS_BASHRC_EDITED -eq 0 ]; then
    echo "source $HOME/.aliasrc" >> $BASHRC_FILE
fi

echo "Install successful."
echo "Aliases will be sourced from the next new shell session. To source them in the current session, do"
echo "    source ~/.aliasrc"
