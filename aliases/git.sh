# Shortucts which are frequently used.
alias gs='git status'
alias gb='git branch'
alias gba='git branch --all'
alias gl='git log'
alias gr='git remote --verbose'
alias gd='git diff'

alias grh='git reset --hard'
alias grs='git reset --soft HEAD^'
alias grco='git rebase --continue'
alias grsk='git rebase --skip'

alias gaa='git add --all'
alias gcam='git commit -a -m'
alias gcaa='git commit -a --amend'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpuom='git pull origin master'

alias gch='git checkout'
alias gchb='git checkout -b'

alias gcx='git add --all && git commit -a -m'

alias grv='git review -y -vvv'


# Fancy ones

# Completely removes the last commit
alias gitremove='git reset --soft HEAD^ && git reset --hard'

alias gdecorate='git log --oneline --graph --decorate --all'

gcl() {
    if [[ -z $1 ]]; then
        echo "usage: gcl <github-user>/<repository>"
        return
    fi
    git clone https://github.com/$1
}

alias gitinit='\
git config --global user.name "Rushi Agrawal"; \
git config --global user.email rushi.agr@gmail.com; \
git config --global --add gitreview.username "rushiagr"; \
git config --global help.autocorrect 1; \
git config --global color.ui true;'

# All the git commands, blindly shortened
alias glog='git log'
alias gcommit='git commit'
alias gshow='git show'
alias gdiff='git diff'
alias gpush='git push'
alias gpull='git pull'
alias grebase='git rebase'
alias gmerge='git merge'
alias grm='git rm'
alias gmv='git mv'
alias gapply='git apply'
alias gclone='git clone'
alias gcheckout='git checkout'
alias gbranch='git branch'
alias gblame='git blame'
alias gstatus='git status'
alias greset='git reset'
alias gremote='git remote'
alias gadd='git add'
alias greview='git review'
