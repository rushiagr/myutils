function mx() {
    if [ -z $1]; then
        tmux -2
    else
        tmux -2 new -s $1
    fi
}

function mxa() {
# Shortcut for 'tmux attach'. If an argument is provided, it attaches to that
# specific session name. If no tmux server is running, it creates one. If an
# argument is provided and no tmux session exists, a new session is created
# with this name
    if [ -z $(ps aux | grep \ Ss\ | grep tmux) ]; then
        if [ -z $1 ]; then
            tmux -2
        else
            tmux -2 new -s $1
        fi
    elif [ -z $1 ]; then
        tmux -2 attach
    else
        tmux -2 attach -t $1
    fi
}

alias mxl='tmux list-sessions'
alias mxd='tmux detach'

alias tmux='tmux -2'
