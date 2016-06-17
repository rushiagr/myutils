alias pmr='python3 manage.py runserver'
alias pmmm='python3 manage.py makemigrations'
alias pmm='python3 manage.py migrate'
alias pm='python3 manage.py'

alias pmr2='python manage.py runserver'
alias pmmm2='python manage.py makemigrations'
alias pmm2='python manage.py migrate'
alias pm2='python manage.py'



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
