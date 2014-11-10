alias fig='find . | grep'
alias ll='ls -alh --group-directories-first'
alias rmf='sudo rm -rf'
alias dfh='df -h' 
alias duh='du -sch'
alias psg='ps aux | grep -i'
alias gi='grep -i' 
alias gri='grep -rinI'
alias fr='free -h'
alias ssh='ssh -X' 
alias wchere='cat $(find .) 2>/dev/null | wc'
alias eg='env | grep -i'
alias cdd='cd ..'
alias cddd='cd ../..'
alias cdddd='cd ../../..'
alias cddddd='cd ../../../..'
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
