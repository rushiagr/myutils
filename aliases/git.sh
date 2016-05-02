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
alias gpom='git push origin master'
alias gpuom='git pull origin master'
# this requires push.default to be set to 'simple'. Note that this might not
# work if the --set-upstream thing is not set
# TODO(rushiagr): do a grep on current branch and push to current branch only
alias gp='git push'
alias gpu='git pull'

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
    # TODO(rushiagr): fix follwing echo
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
        echo "No branch specified. Trying to check out 'master' instead ..."
        git checkout master
        return
    elif [ $1 == '-' ]; then
        git checkout -
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
# BEWARE: If you have any uncommitted changes already present in the working
#   directory, this command is going to clean them up too! Do make sure you
#   run this command when 'git status' show no modified files. I've burnt
#   my fingers already few times!
# TODO(rushiagr): Don't run this command and error out if there are modified
#   files whose changes are not committed are present.
alias gitremove='git reset --soft HEAD^ && git reset --hard'

alias gdecorate='git log --oneline --graph --decorate --all'
alias gde='git log --oneline --graph --decorate --all'

gcl() {
    if [[ -z $1 ]]; then
        echo "usage: gcl <github-user>/<repository> [[<username>:]<password>]"
        return
    fi
    # TODO(rushiagr): no need to first do clone and then update remote. Two
    # steps not needed. Can be done in one.
    git clone https://github.com/$1
    REPO_NAME=$(echo $1 | cut -d '/' -f2)
    cd $REPO_NAME

    GITHUB_USER=rushiagr
    if [[ ! -z $2 ]]; then
        PASSWORD=$2
        # If the second argument contains a colon (':'), that means user
        # has specified username and password both.
        SECOND_SPLIT=$(echo $2 | cut -d':' -f2)
        if [[ ! -z $SECOND_SPLIT ]]; then
            GITHUB_USER=$(echo $2 | cut -d':' -f1)
            PASSWORD=$SECOND_SPLIT
        fi
    fi

    git remote remove origin
    if [[ -z $2 ]]; then
        git remote add origin https://$GITHUB_USER@github.com/$1
    else
        git remote add origin https://$GITHUB_USER:$PASSWORD@github.com/$1
    fi
    cd ..
}

gclbb() {
    # TODO(rushiagr): add 'gcl' like feature where I can or cannot specify a password
    if [[ -z $1 ]]; then
        echo "usage: gclbb <bitbucket-user>/<repository> [<bitbucket-password>]"
        return
    fi
    if [[ -z $2 ]]; then
        git clone https://rushiagr@bitbucket.org/$1.git
    else
        git clone https://rushiagr:$2@bitbucket.org/$1.git
    fi
}

gclgl() {
    # TODO(rushiagr): add more checks before going further, e.g. if there is a
    # '/' in the first argument, etc
    if [[ -z $1 ]]; then
        echo "usage: gclgl <gitlab-user>/<repository> [<gitlab-password>]"
        return
    fi
    if [[ -z $2 ]]; then
        git clone https://rushiagr@gitlab.com/$1.git
    else
        git clone https://rushiagr:$2@gitlab.com/$1.git
    fi
}

alias gitinit='\
git config --global user.name "Rushi Agrawal"; \
git config --global user.email rushi.agr@gmail.com; \
git config --global --add gitreview.username "rushiagr"; \
git config --global help.autocorrect 1; \
git config --global color.ui true; \
git config --global core.editor /usr/bin/vim; \
git config --global push.default simple; \
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
    # "git remote add rushiagr"
    # TODO(rushiagr): move common code of grar and grao to a common function
    if [ ! -z "$1" ]; then
        GIT_PASS=":$1"
    fi

    # TODO(rushiagr): try to get repository name by an already existing remote
    REPONAME=$(pwd | rev | cut -d '/' -f 1 | rev)
    git remote add rushiagr https://rushiagr$GIT_PASS@github.com/rushiagr/$REPONAME
    unset GIT_PASS REPONAME
}

function grao() {
    # "git remote add origin"
    if [ ! -z "$1" ]; then
        GIT_PASS=":$1"
    fi

    # TODO(rushiagr): try to get repository name by an already existing remote
    REPONAME=$(pwd | rev | cut -d '/' -f 1 | rev)
    git remote add origin https://rushiagr$GIT_PASS@github.com/rushiagr/$REPONAME
    unset GIT_PASS REPONAME
}

alias grur='git remote update rushiagr'
alias grrr='git remote remove rushiagr'
alias grro='git remote remove origin'
alias gprm='git push rushiagr master'
alias gpurm='git pull rushiagr master'

# Git push origin <current_branch>
function gpo() {
    CURR_BRANCH=$(git branch | grep ^* | cut -d' ' -f2)
    git push origin $CURR_BRANCH $1
}

# Git pull origin <current_branch>
function gpuo() {
    CURR_BRANCH=$(git branch | grep ^* | cut -d' ' -f2)
    git pull origin $CURR_BRANCH $1
}

# Git push rushiagr <current_branch>
function gpr() {
    CURR_BRANCH=$(git branch | grep ^* | cut -d' ' -f2)
    git push rushiagr $CURR_BRANCH $1
}

# Git pull rushiagr <current_branch>
function gpur() {
    CURR_BRANCH=$(git branch | grep ^* | cut -d' ' -f2)
    git pull rushiagr $CURR_BRANCH $1
}

# gmupdate updates master to latest
alias gmupdate='git checkout master && git pull origin master && git checkout -'

alias gpuoms='git stash && git pull origin master && git stash pop'
