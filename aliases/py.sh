alias pmr='python3 manage.py runserver'
alias pmmm='python3 manage.py makemigrations'
alias pmm='python3 manage.py migrate'
alias pm='python3 manage.py'

alias pmr2='python manage.py runserver'
alias pmmm2='python manage.py makemigrations'
alias pmm2='python manage.py migrate'
alias pm2='python manage.py'

alias pir='pip install -r requirements.txt'
alias spir='sudo pip install -r requirements.txt'

function pe(){
    # Evaluate a python expression
    if [[ -z $1 ]]; then
        echo "usage: pe <python-expression>"
        echo "example:"
        echo "$ pe 22*4"
        echo "$ 88"
        return
    fi
    python -c "print $1"
}

alias getpip='cd /tmp && wget https://bootstrap.pypa.io/get-pip.py && sudo -H -E python get-pip.py && cd -'

alias pf='pip freeze'
alias pfg='pip freeze | grep -i'
alias pi='pip install'
alias piu='pip install --upgrade'

alias spf='sudo -E pip freeze'
alias spfg='sudo -E pip freeze | grep -i'
alias spi='sudo -E pip install'
alias spiu='sudo -E pip install --upgrade'

# Activate my python virtual environments
alias mye2='source ~/etc/venvpy27/bin/activate'
alias mye3='source ~/etc/venvpy35/bin/activate'

# venv activate
function va() {
#1. if a directory is specified:
#        if the directory exists:
#            activate venv
#        if doesnt;
#            create directory and put venv in it and activate
#2. if a directory is not specified:
#    go recursively above and above and find a '.venv' directory and activate it if found, else return

    ORIG_DIR=$(pwd)
    if [ -z $1 ]; then
        VENV_DIR_NAME=".venv"
    else
        VENV_DIR_NAME=$1
    fi

    while true; do
        CURR_DIR=$(pwd)
        if [ $(ls -a $CURR_DIR | grep -c "setup\.py$\|$VENV_DIR_NAME$") -gt 0 ]; then
            break
        elif [ $CURR_DIR == '/' ]; then
            echo 'No setup.py found in current or any parent directory.'
            cd $ORIG_DIR
            return
        else
            cd ..
        fi
    done

    echo "Virtualenv activated in $CURR_DIR"

    if [ $(ls -a | grep -c "$VENV_DIR_NAME$") -eq 0 ]; then
        echo "setup.py found at $CURR_DIR, but no $VENV_DIR_NAME dir is found. Creating..."
        virtualenv $VENV_DIR_NAME
    fi

    . $VENV_DIR_NAME/bin/activate

    cd $ORIG_DIR
}

# 'DeActivate'
alias da='deactivate'

# TODO(rushiagr): 'vah' and 'vah3' should also take a directory which is
# outside of current directory, e.g. '../../myvenvdir'
# TODO(rushiagr): most code in vah and vah3 is common. Extract it out to a
# different function

function vah() {
    if [ -z $1 ]; then
        VENV_DIR_NAME=".venv"
    else
        VENV_DIR_NAME=$1
    fi
    if [ $(ls -a | grep -c $VENV_DIR_NAME) -eq 0 ]; then
        virtualenv $VENV_DIR_NAME
    fi
    . $VENV_DIR_NAME/bin/activate
}

function vah3() {
    if [ -z $1 ]; then
        VENV_DIR_NAME=".venv"
    else
        VENV_DIR_NAME=$1
    fi
    if [ $(ls -a | grep -c $VENV_DIR_NAME) -eq 0 ]; then
        virtualenv -p python3 $VENV_DIR_NAME

    fi
    . $VENV_DIR_NAME/bin/activate
}
