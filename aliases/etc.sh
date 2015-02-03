alias fig='find . | grep --color=always'
alias ll='ls -alh --group-directories-first'
alias rmf='sudo rm -rf'
alias dfh='df -h'
alias duh='du -sch'
alias psg='ps aux | grep -i --color=always'
alias gi='grep -i'
alias gri='grep -rinI --color=always'
# Grep no-ignore-case
alias grin='grep -rnI --color=always'
alias fr='free -h'
alias ssh='ssh -X'
alias wchere='cat $(find .) 2>/dev/null | wc'
alias eg='env | grep -i'
alias egp='env | grep proxy'
alias less='less -R'
alias l='less -R'

alias cdd='cd ..'
alias cddd='cd ../..'
alias cdddd='cd ../../..'
alias cddddd='cd ../../../..'
alias cdddddd='cd ../../../../..'
alias cddddddd='cd ../../../../../..'

alias cds='cd ~/src'
alias cdn='cd ~/notes'
alias cdv='cd ~/vagrant'

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


alias pms='sudo pm-suspend-hybrid'

alias pig='ping google.com'
