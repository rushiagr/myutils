# This file contains bash aliases and functions. Sourcing this file doesn't
# change the behavior of the system and just loads a few more handy aliases and
# functions into the environment.

alias fig='find . | grep --color=always -i'
alias ll='ls -alrth'
alias lsg='ls | grep'
alias lsn="ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'"
alias l='ls -alrth'
alias lsa='ls -a'
alias lsdir='ls -d */'
alias rmf='sudo rm -rf'
alias dfh='df -h'
alias duh='du -sch'
alias psg='ps aux | grep -i --color=always'
alias gi='grep -i'
alias gri='grep -rinI --color=always --exclude-dir=.git --exclude-dir=.eggs --exclude-dir=.venv --exclude-dir=tags --exclude-dir=tests --exclude=tags'
alias griv='grep -rinI --color=always --exclude-dir=.git --exclude-dir=.venv --exclude-dir=tags'
# Grep no-ignore-case
alias grin='grep -rnI --color=always --exclude-dir=.git --exclude-dir=.venv --exclude-dir=tags'
alias fr='free -h'
alias ssh='ssh -X'
alias wchere='cat $(find .) 2>/dev/null | wc'
alias eg='env | grep -i'
alias egp='env | grep proxy'
alias less='less -R'

alias cdd='cd ..'
alias cddd='cd ../..'
alias cdddd='cd ../../..'
alias cddddd='cd ../../../..'
alias cdddddd='cd ../../../../..'
alias cddddddd='cd ../../../../../..'
alias cdp='cd -'

function cds() {
    cd ~/src/$1
}
function cdn() {
    cd ~/notes/$1
}
alias cdv='cd ~/vagrant'
alias cdw='cd ~/ws'

function cd() {
# Improved 'cd' command
# If I write 'cd /dir1/dir2/dir3/t', where I typed 't' accidentally, take
# me anyway to /dir1/dir2/dir3/.
# TODO(rushiagr): Add colourful message in green whenever we're doing an
#   intelligent 'cd' :)
    if [[ -z $1 ]]; then
        builtin cd
        return
    fi
    builtin cd "${1}" > /dev/null 2>&1
    RETVAL=$?

    if [[ $RETVAL != 0 ]]; then
        # If there is exactly one directory which matches pattern *$1*,
        # case-insensitively, where $1 is the first argument, then cd to that
        # directory. E.g. If there are four directories 'one', 'two', 'three',
        # 'four', and you do `cd hr`, then cd into 'three' directory.
        matching_dir_count=$(ls | grep -i -c "${1}")
        if [[ $matching_dir_count == 1 ]]; then
            matching_dir=$(ls | grep -i "${1}")
            builtin cd $matching_dir
            return
        fi

        TRAILING_DIR_INPUT=$(echo $(pwd)/"${1}" | rev | cut -d'/' -f1 | rev)
        # If exactly one directory pattern-matches $2, go to that directory
        # e.g. if the command is 'cd a/t' and there are two directories
        # 'a/one/' and 'a/two/', then cd the user to 'a/two/' directory
        PENULTIMATE_PATH=$(echo $(pwd)/"${1}" | rev | cut -d'/' -f2- | rev)
        # NOTE: I could have done:
        #   DIRS_IN_PENULTIMATE_PATH=$(ls -alrth $PENULTIMATE_PATH | grep ^d | grep [^.]$ | rev | cut -d ' ' -f 1 | rev)
        # and used this variable below. Instead, I'm doing this work twice below
        # The problem is that whenever I do a 'grep -c' on this variable
        # won't ever return a value greater than 1. This is because once I put
        # data from a command into a variable, the variable will put all the
        # values from multiple line into a single line.
        # TODO(rushiagr): make the above comment more readable :)
        if [[ $(ls -alrth $PENULTIMATE_PATH | grep ^d | grep [^.]$ | rev | cut -d ':' -f1 | rev | cut -d ' ' -f2- | grep -ic ^$TRAILING_DIR_INPUT) == 1 ]]; then
            MATCHED_DIR_IN_PENULTIMATE_PATH=$(ls -alrth $PENULTIMATE_PATH | grep ^d | grep [^.]$ | rev | cut -d ':' -f1 | rev | cut -d ' ' -f2- | grep -i ^$TRAILING_DIR_INPUT)
            FINAL_DIR=$(echo $PENULTIMATE_PATH/$MATCHED_DIR_IN_PENULTIMATE_PATH)
            builtin cd "${FINAL_DIR}"
        else
            # Either there are more than one matches, or no matches. In either
            # case, just go to the penultimate path
            builtin cd "${PENULTIMATE_PATH}"
        fi
    fi
}

function pingbg() {
  ping -i 60 $1 >/dev/null 2>&1 &
}
alias fs='sudo chown stack:stack `readlink /proc/self/fd/0`'

# Usage: cat file | aw 2,3,4
function aw() {
    awk "{print \$${1:-1}}" $2;
}

# Kill all the processes which matches specified pattern. Won't kill sudo
# processes
function pskill() {
    kill -9 $(ps aux | grep -i $1 | awk '{print $2}')
}

# 'sudo pskill'
function spskill() {
    sudo kill -9 $(ps aux | grep -i $1 | awk '{print $2}')
}

# Find common lines between two files
function common () {
    comm -12 <(sort $1) <(sort $2)
}

alias venv='source ~/src/venvs/main/bin/activate'
alias quit='exit'
alias unproxy='unset http_proxy https_proxy no_proxy'
alias d='date'
alias ud='TZ=UTC date' # UTC date

# 'S'ou'R'ce aliasrc. Useful only while sourcing updated aliasrc. Won't be
# available for sourcing for the first time obviously
alias sr='source ~/.aliasrc'

alias cdl='cd -'

alias vv='vim Vagrantfile'
alias vim='if [[ $TERM == "xterm" ]]; then export TERM=xterm-256color; fi; vim'
alias svim='if [[ $TERM == "xterm" ]]; then export TERM=xterm-256color; fi; sudo vim'
alias sv='svim'


alias pp='sudo pm-suspend-hybrid'

alias pig='ping google.com'

#function dk() {
#    wget -b -O dkdm$1\.mp4 http://media.startv.in/newstream/star/lifeok/mahadev/$1/lf_300.mp4
#}
#
#function dkl() {
#    for (( c=$1; c<=$2; c++ )); do
#        dk $c
#    done
#}

alias mys='mysql --pager="less -SFX" -uroot -pnova -h $(ifconfig lo0 | grep "inet " | aw 2)'

alias sx='screen -x'

alias gow='\
    export GOPATH=$HOME/src/go; \
    export PATH=$PATH:$HOME/src/go:$HOME/src/go/bin;'

alias astp='sudo service apache2 stop'
alias arst='sudo service apache2 restart'
alias astr='sudo service apache2 start'
alias are='sudo service apache2 reload'
alias astt='sudo service apache2 status'

alias airkill="sudo kill -9 $(ps aux | grep -i airtel | awk '{print $2}' | grep -v auto)"

function f() {
    for i in `seq 1 10`; do
        $*
    done
}

function fdelay() {
    for i in `seq 1 10`; do
        sleep 1
        $*
    done
}


alias q="exit"

alias cer='cat /etc/resolv.conf'
alias ceh='cat /etc/hosts'
alias teh='tail /etc/hosts'
alias veh='sudo vim /etc/hosts'
alias ver='sudo vim /etc/resolv.conf'


# Alias to convert all files and directories to normal permissions
function fixfileperms() {
    find * -type d -print0 | xargs -0 chmod 0755 # for directories
    find . -type f -print0 | xargs -0 chmod 0644 # for files
}

alias gcu='git commit -m "update $(date)"'

alias qr="python ~/src/myutils/otherfiles/quotesroll.py $USER"

function setupnewuser() {
    # Creates a new user, and gives passwordless sudo privileges to that user.
    # There's just one small problem: the user won't have colours for the
    # terminal, and some basic bash shortcut aliases like 'll'
    USER=$1
    OLD_USER=$(users) # NOT a good way actually
    sudo addgroup $USER
    sudo /usr/sbin/adduser --system --home /home/$USER --shell /bin/bash  --ingroup $USER --gecos "$USER" $USER

    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/21_$USER

    sudo -u $USER -H bash -c "sudo mkdir -p ~/.ssh"
    sudo -u $USER -H bash -c "pwd"
    sudo -u $USER -H bash -c "sudo cp /home/$OLD_USER/.ssh/authorized_keys ~/.ssh"
    sudo -u $USER -H bash -c "sudo chown $USER:$USER ~/.ssh/authorized_keys"
}

function hugo_new() {
    if [[ -z $1 ]]; then
        echo "usage: hugo_new blog-post-name.md"
        return
    fi

    CURR_DIR=$(pwd | rev | cut -d '/' -f 1 | rev)

    if [ $CURR_DIR != 'npf' ]; then
        echo 'This command should be executed from inside "npf" directory'
        return
    fi

    hugo new $1 2>&1 >> /dev/null
    mv content/$1 content/blog/

    sed -i s/menu\ \=\ \"main\"/type\ \=\ \"post\"/g content/blog/$1

    echo "Blog file ready at content/blog/$1"
}

# TODO(rushiagr): make color more beautiful. Red is kind of dull..
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

alias cxp='curl -XPOST -H "Authorization: token $MYTOKEN" -H "Content-Type: application/json"'
alias cx='curl -H "Authorization: token $MYTOKEN" -H "Content-Type: application/json"'

alias his='history | awk '"'"'{$1="";print substr($0,2)}'"'"''
alias hisl='his | less'

alias pkgupload='python setup.py bdist_wheel && twine upload dist/$(ls -t dist/ | head -1)'

alias c6='chmod 600'

# Mac battery
function macbat() {
    # TODO: Don't make call to 'ioreg' twice. It's too bulky a call.
    currentcapacity=$(ioreg -l | grep CurrentCapacity | awk '{print $5}')
    maxcapacity=$(ioreg -l | grep MaxCapacity | awk '{print $5}')
    echo $(($currentcapacity*100 / $maxcapacity ))
}

# In Mac, htop needs to be run as sudo to see CPU and memory usage
alias htop='sudo htop'
alias dk='sudo docker'

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

alias chromemem="ps aux | grep 'Chrome' | awk '{vsz += $5; rss += $6} END { print \"vsz=\"vsz, \"rss=\"rss }'"

function dirmd5sum() {
    # Works with only 'gmd5sum' for now. Expects directory name as arg
    find -s $1 -type f -exec gmd5sum {} \; | gmd5sum
}
