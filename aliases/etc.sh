alias fig='find . | grep'
alias ll='ls -alh --group-directories-first'
alias rmf='sudo rm -rf'
alias dfh='df -h' 
alias duh='du -sch'
alias psg='ps aux | grep'
alias gi='grep -i' 
alias gri='grep -rinI'
alias frh='free -h'
alias ssh='ssh -X' 
alias wchere='cat $(find .) 2>/dev/null | wc'
alias eg='env | grep -i'
alias cdd='cd ..'
alias cddd='cd ../..'
alias cdddd='cd ../../..'
alias cddddd='cd ../../../..'
function pingbg() {
  ping -i 60 $1 >/dev/null 2>&1 &
}
