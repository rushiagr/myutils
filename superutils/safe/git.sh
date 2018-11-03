# Shortucts which are frequently used.
alias gs='git status --short --branch'
alias gb='git branch'
alias gba='git branch --all'
alias gl='git log'
alias gr='git remote --verbose'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'

alias gds='git diff --stat'
alias grh='git reset --hard'
alias grs='git reset --soft HEAD^'
alias grco='git rebase --continue'
alias grsk='git rebase --skip'
alias grim='git rebase -i master'

alias gc='git commit'
alias gaa='git add --all :/'
alias gap='git add -p'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcaa='git commit -a --amend'
alias gpom='git push origin master'
alias gpuom='git pull origin master'
# this requires push.default to be set to 'simple'. Note that this might not
# work if the --set-upstream thing is not set
alias gp='git push'
alias gpu='git pull'

alias gpomd='git push origin master >/dev/null 2>&1 &'

alias gchb='git checkout -b'
alias gchm='git checkout master'
alias gchp='git checkout -p'


function gru() {
    if [[ -z $1 ]]; then
        git remote update
        return
    fi

    for remote_to_update in $*; do
        # Even if few initial characters of a remote name are specified,
        # pattern-match and update that remote.
        remotes=$(git remote)
        num_matches=0
        last_match=''
        for r in $remotes; do
            match=$(echo $r | grep "^$remote_to_update")
            if [[ ! -z $match ]]; then
                num_matches=$(($num_matches+1))
                last_match=$match
            fi
        done
        if [ $num_matches -eq 0 ]; then
            echo "No remote matches pattern '^$remote_to_update'"
        elif [ $num_matches -eq 1 ]; then
            echo "Updating remote $last_match"
            git remote update $last_match
        else
            echo "Multiple remotes match pattern '^$remote_to_update'"
        fi
    done
}

function gbd() {
    if [[ -z $1 ]]; then
        echo "No branch specified"
        return
    fi

    for branch_to_delete in $*; do
        branches=$(git branch | cut -d'*' -f2 | awk '{print $1}')
        num_matches=0
        last_match=''
        for br in $branches; do
            match=$(echo $br | grep "^$branch_to_delete")
            if [[ ! -z $match ]]; then
                num_matches=$(($num_matches+1))
                last_match=$match
            fi
        done
        if [ $num_matches -eq 0 ]; then
            echo "No branch matches pattern '^$branch_to_delete'"
        elif [ $num_matches -eq 1 ]; then
            git branch -D $last_match
        else
            echo "Multiple branches match pattern '^$branch_to_delete'"
        fi
    done
}

function gch() {
    # Shortcut for 'git checkout'. No need to enter full branch name as the
    # first parameter. Instead, you just need to enter first few
    # distinguishing characters

    if [[ -z $1 ]]; then
        echo "No branch specified. Trying to check out 'master' instead ..."
        git checkout master
        return
    elif [[ $1 == '-' ]]; then
        git checkout -
        return
    fi

    branches=$(git branch | cut -d'*' -f2 | awk '{print $1}')
    num_matches=0
    last_match=''
    for br in $branches; do
        # If branch with exact name found, check that out and return
        exact_match=$(echo $br | grep "^$1$")
        if [[ ! -z $exact_match ]]; then
            git checkout $exact_match
            return
        fi

        match=$(echo $br | grep "^$1")
        if [[ ! -z $match ]]; then
            num_matches=$(($num_matches+1))
            last_match=$match
        fi
    done
    if [ $num_matches -eq 0 ]; then
        # Check if a matching branch exists at one of the remotes
        remote_branch_count=$(git branch -a | sed s/\ //g | grep ^remotes | grep -c $1)
        if [[ $remote_branch_count -eq 0 ]]; then
            echo "No branch matches pattern '^$1'"
        else
            remote_branch_name=$(git branch -a | sed s/\ //g | grep ^remotes | grep $1)
            remote_branch_name=$(echo $remote_branch_name | cut -d '/' -f 3-)
            git checkout $remote_branch_name
        fi
    elif [ $num_matches -eq 1 ]; then
        git checkout $last_match
    else
        echo "Multiple branch matches pattern '^$1'"
    fi
}


alias gcx='git add --all && git commit -a -m'

# Fancy ones

# Completely removes the last commit
# TODO(rushiagr): If there are modified files, instead of stashing them, raise
# a warning and exit.
# TODO(rushiagr): there exists a better method to do this. Figure it out and
# use that instead
alias gitremove='git stash && git reset --soft HEAD^ && git reset --hard'

alias gdecorate='git log --oneline --graph --decorate --all'
alias gde='git log --oneline --graph --decorate --all'

_base_gcl() {
    # Param 1: website (e.g. 'github.com', 'gitlab.com', 'bitbucket.org')
    # Param 2: repository (e.g. 'rushiagr/myutils')
    # Param 1: [username:]password (e.g. 'mypassword', 'myusername:mypassword')
    if [[ -z $2 ]]; then
        echo "usage: gcl <$1-user>/<repository> [[<username>:]<password>]"
        return
    fi

    GITHUB_USER=rushiagr
    if [[ ! -z $3 ]]; then
        PASSWORD=$3
        # If the second argument contains a colon (':'), that means user
        # has specified username and password both.
        HAS_COLON=$(echo $3 | grep -c ":")
        if [[ $HAS_COLON == 1 ]]; then
            GITHUB_USER=$(echo $3 | cut -d':' -f1)
            PASSWORD=$SECOND_SPLIT
        fi
    fi

    if [[ -z $3 ]]; then
        git clone https://$GITHUB_USER@$1/$2.git
    else
        git clone https://$GITHUB_USER:$PASSWORD@$1/$2.git
    fi
}

gcl() {
    _base_gcl github.com $1 $2
}

gclbb() {
    _base_gcl bitbucket.org $1 $2
}

gclgl() {
    _base_gcl gitlab.com $1 $2
}

alias gitinit='\
git config --global user.name "Rushi Agrawal"; \
git config --global user.email rushi.agr@gmail.com; \
git config --global help.autocorrect 1; \
git config --global color.ui true; \
git config --global core.editor /usr/bin/vim; \
git config --global push.default simple; \
git config --global core.excludesfile ~/.gitignore_global;'

alias gitinit='\
git config --global user.name "Rushi Agrawal"; \
git config --global user.email agrrushi@amazon.com;'

# All the git commands, blindly shortened
alias gsh='git show'
alias gshs='git show --shortstat'

_base_grax() {
    # param 1: remote name
    # param 2: git user's password
    # "git remote add rushiagr"

    if [ ! -z "$2" ]; then
        GIT_PASS=":$2"
    fi

    # TODO(rushiagr): try to get repository name by an already existing remote
    REPONAME=$(pwd | rev | cut -d '/' -f 1 | rev)
    git remote add rushiagr https://rushiagr$GIT_PASS@github.com/rushiagr/$REPONAME
    unset GIT_PASS REPONAME
}

function grar() {
    _base_grax rushiagr $1
}

function grao() {
    _base_grax origin $1
}

alias grur='git remote update rushiagr'
alias gruo='git remote update origin'
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

# gmupdate updates master to latest. Mnemonic: 'git master update'
alias gmupdate='git checkout master && git pull origin master && git checkout -'

alias gpuoms='git stash && git pull origin master && git stash pop'

function git_update_last_commit_time() {
    LC_ALL=C GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)"
}
