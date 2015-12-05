# Shortucts which are frequently used.
alias gs='git status'
alias gb='git branch'
alias gba='git branch --all'
alias gl='git log'
alias gr='git remote --verbose'
alias gd='git diff'
alias ga='git add'

alias grh='git reset --hard'
alias grs='git reset --soft HEAD^'
alias grco='git rebase --continue'
alias grsk='git rebase --skip'
alias grim='git rebase -i master'

alias gc='git commit'
alias gaa='git add --all'
alias gap='git add -p'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcaa='git commit -a --amend'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpuom='git pull origin master'

alias gpomd='git push origin master >/dev/null 2>&1 &'

alias gchb='git checkout -b'
alias gchm='git checkout master'


function gru() {
    if [[ -z $1 ]]; then
        git remote update
        return
    fi
    if [[ ! -z $2 ]]; then
        REMOTES=$*
        # TODO(rushiagr): Add support for specifying regexes as parameters
        #   to 'gru' instead of remote names. So if there are two remotes
        #   'origin' and 'anotherremote', I should be able to just say
        #   'gru o a' and it should update both remotes.
        # TODO(rushiagr): Add the feature described in the above todo to
        #   other methods too where it makes sense
        echo 'Updating remotes: $* ...'
        for REMOTE in $REMOTES; do
            git remote update $REMOTE
        done
    fi

    # Even if few initial characters of a remote name are specified,
    # pattern-match and update that remote.
    remotes=$(git remote)
    num_matches=0
    last_match=''
    for r in $remotes; do
        match=$(echo $r | grep "^$1")
        if [[ ! -z $match ]]; then
            num_matches=$(($num_matches+1))
            last_match=$match
        fi
    done
    if [ $num_matches -eq 0 ]; then
        echo "No remote matches pattern '^$1'"
    elif [ $num_matches -eq 1 ]; then
        git remote update $last_match
    else
        echo "Multiple remotes matches pattern '^$1'"
    fi
}

function gbd() {
    if [[ -z $1 ]]; then
        echo "No branch specified"
        return
    fi
    if [[ ! -z $2 ]]; then
        echo "You can only delete one branch at a time, for now"
        return
    fi

    branches=$(git branch | cut -d'*' -f2 | awk '{print $1}')
    num_matches=0
    last_match=''
    for br in $branches; do
        match=$(echo $br | grep "^$1")
        if [[ ! -z $match ]]; then
            num_matches=$(($num_matches+1))
            last_match=$match
        fi
    done
    if [ $num_matches -eq 0 ]; then
        echo "No branch matches pattern '^$1'"
    elif [ $num_matches -eq 1 ]; then
        git branch -D $last_match
    else
        echo "Multiple branch matches pattern '^$1'"
    fi
}

function gch() {
    # Shortcut for 'git checkout'. No need to enter full branch name as the
    # first parameter. Instead, you just need to enter first few
    # distinguishing characters
    if [[ -z $1 ]]; then
        echo "No branch specified"
        return
    fi
    branches=$(git branch | cut -d'*' -f2 | awk '{print $1}')
    num_matches=0
    last_match=''
    for br in $branches; do
        match=$(echo $br | grep "^$1")
        if [[ ! -z $match ]]; then
            num_matches=$(($num_matches+1))
            last_match=$match
        fi
    done
    if [ $num_matches -eq 0 ]; then
        echo "No branch matches pattern '^$1'"
    elif [ $num_matches -eq 1 ]; then
        git checkout $last_match
    else
        echo "Multiple branch matches pattern '^$1'"
    fi
}


alias gcx='git add --all && git commit -a -m'

alias grv='git review -y -vvv'


# Fancy ones

# Completely removes the last commit
alias gitremove='git reset --soft HEAD^ && git reset --hard'

alias gdecorate='git log --oneline --graph --decorate --all'
alias gde='git log --oneline --graph --decorate --all'

gcl() {
    if [[ -z $1 ]]; then
        echo "usage: gcl <github-user>/<repository> [<github-password>]"
        return
    fi
    git clone https://github.com/$1
    repo_name=$(echo $1 | cut -d '/' -f2)
    cd $repo_name
    git remote remove origin
    if [[ -z $2 ]]; then
        git remote add origin https://rushiagr@github.com/$1
    else
        git remote add origin https://rushiagr:$2@github.com/$1
    fi
    cd ..
}

gclbb() {
    if [[ -z $1 ]]; then
        echo "usage: gclbb <bitbucket-user>/<repository> [<bitbucket-password>]"
        return
    fi
    git clone https://bitbucket.org/$1
    repo_name=$(echo $1 | cut -d '/' -f2)
    cd $repo_name
    git remote remove origin
    if [[ -z $2 ]]; then
        git remote add origin https://rushiagr@bitbucket.org/$1
    else
        git remote add origin https://rushiagr:$2@bitbucket.org/$1
    fi
    cd ..
}

gclgl() {
    if [[ -z $1 ]]; then
        echo "usage: gclgl <gitlab-user>/<repository> [<gitlab-password>]"
        return
    fi
    git clone https://gitlab.com/$1.git
    repo_name=$(echo $1 | cut -d '/' -f2)
    cd $repo_name
    git remote remove origin
    if [[ -z $2 ]]; then
        git remote add origin https://rushi-agr@gitlab.com/$1.git
    else
        git remote add origin https://rushi-agr:$2@gitlab.com/$1.git
    fi
    cd ..
}

alias gitinit='\
git config --global user.name "Rushi Agrawal"; \
git config --global user.email rushi.agr@gmail.com; \
git config --global --add gitreview.username "rushiagr"; \
git config --global help.autocorrect 1; \
git config --global color.ui true; \
git config --global core.editor /usr/bin/vim; \
git config --global core.excludesfile ~/.gitignore_global;'

# All the git commands, blindly shortened
alias glog='git log'
alias gcommit='git commit'
alias gsh='git show'
alias gdiff='git diff'
alias gpush='git push'
alias gpull='git pull'
alias grebase='git rebase'
alias gmerge='git merge'
alias grm='git rm'
alias gmv='git mv'
alias gapply='git apply --ignore-space-change --ignore-whitespace'
alias gclone='git clone'
alias gcheckout='git checkout'
alias gbranch='git branch'
alias gblame='git blame'
alias gstatus='git status'
alias greset='git reset'
alias gremote='git remote'
alias gadd='git add'
alias greview='git review'

# My remote operations
function grar() {
    if [ ! -z "$1" ]; then
        GIT_PASS=":$1"
    fi

    # TODO(rushiagr): try to get repository name by an already existing remote
    REPONAME=$(pwd | rev | cut -d '/' -f 1 | rev)
    git remote add rushiagr https://rushiagr$GIT_PASS@github.com/rushiagr/$REPONAME
    unset GIT_PASS REPONAME
}

alias grur='git remote update rushiagr'
alias grrr='git remote remove rushiagr'
alias gprm='git push rushiagr master'
alias gpurm='git pull rushiagr master'
