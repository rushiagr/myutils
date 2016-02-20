alias fig='find . | grep --color=always -i'
alias ll='ls -alh --group-directories-first'
alias rmf='sudo rm -rf'
alias dfh='df -h'
alias duh='du -sch'
alias psg='ps aux | grep -i --color=always'
alias gi='grep -i'
alias gri='grep -rinI --color=always --exclude-dir=.git --exclude-dir=.venv'
alias griv='grep -rinI --color=always --exclude-dir=.git'
# Grep no-ignore-case
alias grin='grep -rnI --color=always'
alias fr='free -h'
alias ssh='ssh -X'
alias wchere='cat $(find .) 2>/dev/null | wc'
alias eg='env | grep -i'
alias egp='env | grep proxy'
alias less='less -R'
alias l='ls -alrth'

alias cdd='cd ..'
alias cddd='cd ../..'
alias cdddd='cd ../../..'
alias cddddd='cd ../../../..'
alias cdddddd='cd ../../../../..'
alias cddddddd='cd ../../../../../..'

function cds() {
    cd ~/src/$1
}
function cdn() {
    cd ~/notes/$1
}
alias cdv='cd ~/vagrant'

function cd() {
# Improved 'cd' command
# If I write 'cd /dir1/dir2/dir3/t', where I typed 't' accidentally, take
# me anyway to /dir1/dir2/dir3/.
# TODO(rushiagr): Add colourful message in green whenever we're doing an
#   intelligent 'cd' :)
# TODO(rushiagr): doesn't work when the file path has space in it. Maybe I
#   need to do something like $VAR -> $"{VAR}" type transformation
    if [[ -z $1 ]]; then
        builtin cd
        return
    fi
    builtin cd "${1}" > /dev/null 2>&1
    RETVAL=$?

    if [[ $RETVAL != 0 ]]; then
        TRAILING_DIR_INPUT=$(echo $(pwd)/"${1}" | rev | cut -d'/' -f1 | rev)
        #return
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
        if [[ $(ls -alrth $PENULTIMATE_PATH | grep ^d | grep [^.]$ | rev | cut -d ' ' -f 1 | rev | grep -c ^$TRAILING_DIR_INPUT) == 1 ]]; then
            MATCHED_DIR_IN_PENULTIMATE_PATH=$(ls -alrth $PENULTIMATE_PATH | grep ^d | grep [^.]$ | rev | cut -d ' ' -f 1 | rev | grep ^$TRAILING_DIR_INPUT)
            FINAL_DIR=$(echo $PENULTIMATE_PATH/$MATCHED_DIR_IN_PENULTIMATE_PATH)
            #/usr/bin/cd $PENULTIMATE_PATH/$MATCHED_DIR_IN_PENULTIMATE_PATH
            #/usr/bin/cd $FINAL_DIR
            builtin cd $FINAL_DIR
            return # TODO(rushiagr): looks like this return statement is unnecessary
        else
            # Either there are more than one matches, or no matches. In either
            # case, just go to the penultimate path
            builtin cd $PENULTIMATE_PATH
        fi
    fi
}

function pingbg() {
  ping -i 60 $1 >/dev/null 2>&1 &
}
alias fs='sudo chown stack:stack `readlink /proc/self/fd/0`'

function aw() {
    awk "{print \$${1:-1}}" $2;
}

alias venv='source ~/src/venvs/main/bin/activate'
alias quit='exit'
alias unproxy='unset http_proxy https_proxy no_proxy'
alias d='date'
alias ud='TZ=UTC date' # UTC date

# 'S'ou'R'ce aliasrc. Useful only while sourcing updated aliasrc. Won't be
# available for sourcing for the first time obviously
alias sr='source ~/.aliasrc'

# C-w to erase upto last '/' character, and not till last whitespace
stty werase undef
bind '\C-w:unix-filename-rubout'

alias cdl='cd -'

alias vv='vim Vagrantfile'
alias vim='if [ $TERM == "xterm" ]; then export TERM=xterm-256color; fi; vim'
alias svim='if [ $TERM == "xterm" ]; then export TERM=xterm-256color; fi; sudo vim'
alias sv='svim'


alias pp='sudo pm-suspend-hybrid'

alias pig='ping google.com'

function dk() {
    wget -b -O dkdm$1\.mp4 http://media.startv.in/newstream/star/lifeok/mahadev/$1/lf_300.mp4
}

function dkl() {
    for (( c=$1; c<=$2; c++ )); do
        dk $c
    done
}

alias mys='mysql --pager="less -SFXX" -uroot -pkaka123'
alias sx='screen -x'

alias gow='\
    export GOPATH=$HOME/src/go; \
    export PATH=$PATH:$HOME/src/go;'

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

# Mac battery
function macbat() {
    # TODO: Don't make call to 'ioreg' twice. It's too bulky a call.
    currentcapacity=$(ioreg -l | grep CurrentCapacity | awk '{print $5}')
    maxcapacity=$(ioreg -l | grep MaxCapacity | awk '{print $5}')
    echo $(($currentcapacity*100 / $maxcapacity ))
}

alias q="exit"

alias cer='cat /etc/resolv.conf'
alias ceh='cat /etc/hosts'
alias teh='tail /etc/hosts'

# venv activate
alias va='. .venv/bin/activate'
# 'DeActivate'
alias da='deactivate'
