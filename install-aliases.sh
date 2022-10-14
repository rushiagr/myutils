#! /bin/zsh -eu

# Script which sets everthing up in a system


UNAME=$(uname)

function sedeasy {
    if [[ $UNAME == "Darwin" ]]; then
          sed -i "" "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
      else
        sed -i "s/$(echo $1 | sed -e 's/\([[\/.*]\|\]\)/\\&/g')/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
    fi
}

ZSHRC_FILE="$HOME/.zshrc"


if [[ $UNAME == "Darwin" ]]; then
    if [[ $(brew list | grep -c coreutils) == "0" ]]; then
        echo "'coreutils' brew package not installed. Installing now..."
        brew install coreutils
    fi
    CURR_FILE_PATH=$(greadlink -f $0)
    ZSHRC_FILE="$HOME/.zprofile"
else
    CURR_FILE_PATH=$(readlink -f $0)
fi

MYUTILS_DIR_PATH=$(echo $CURR_FILE_PATH | rev | cut -d'/' -f2- | rev)

cat ${MYUTILS_DIR_PATH}/superutils/safe/* >  $HOME/.aliasrc
cat ${MYUTILS_DIR_PATH}/unsafe/* >>  $HOME/.aliasrc

export IS_ZSHRC_EDITED=$(cat $ZSHRC_FILE | grep -c "source $HOME/.aliasrc")

if [[ $IS_ZSHRC_EDITED -eq 0 ]]; then
    echo "source $HOME/.aliasrc" >> $ZSHRC_FILE
fi

DOTFILES=$(ls -a $MYUTILS_DIR_PATH/dotfiles | grep "^\\.[a-zA-Z]")

TEMPDIR=""
for DOTFILE in $(echo $DOTFILES); do
    if [[ -f $HOME/${DOTFILE} ]]; then
        if [[ "${TEMPDIR}" == "" ]]; then
            TEMPDIR=$(mktemp -d /tmp/myutils-backup-$(date +"%y%m%d%H%M%S")-XXXX)
        fi
        mv $HOME/$DOTFILE $TEMPDIR
    fi

    if [[ $UNAME == "Darwin" ]]; then
        gcp --recursive $MYUTILS_DIR_PATH/dotfiles/$DOTFILE $HOME
    else
        cp --recursive $MYUTILS_DIR_PATH/dotfiles/$DOTFILE $HOME
    fi
done

echo "Installing TPM, Tmux Plugin Manager"
echo "Deleting existing TPM directory if already present..."
rm -rf ~/.tmux/plugins/tpm
echo "Now cloning TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Done setting up TPM"

echo "Install successful."
echo "Aliases will be sourced from the next new shell session. To source them in the current session, do"
echo "    source ~/.aliasrc"

if [[ "${TEMPDIR}" != "" ]]; then
    echo -e "\nThe following existing dotfiles are moved to temp dir $TEMPDIR:"
    echo $(ls -a $TEMPDIR | grep "^\\.[a-zA-Z]")
fi

# Section where pathogen and all vim plugins are set up.blah
mkdir -p ~/.vim/autoload ~/.vim/bundle

if [[ $(ls ~/.vim/autoload/  | grep -c pathogen.vim$) == 0 ]]; then
    echo "Pathogen not present. Downloading pathogen after 10 seconds. Press Ctrl-C to abort"
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
    echo "Pathogen already set up"
fi

vim_plugins_to_download=0
cd ~/.vim/bundle
for repo_url in $(cat $MYUTILS_DIR_PATH/vim-plugins); do
    plugin_name=$(echo $repo_url | rev | cut -d/ -f1 | rev)
    if [[ $(ls ~/.vim/bundle/ | grep -c $plugin_name$) == 0 ]]; then
        if [[ $vim_plugins_to_download == 0 ]]; then
            echo "Downloading vim plugins after 10 seconds. Press Ctrl-C to abort"
        fi
        git clone $repo_url
    fi
done
if [[ $vim_plugins_to_download == 0 ]]; then
    echo "All VIM plugins already installed"
fi
