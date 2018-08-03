function mx() {
    if [[ -z $1 ]]; then
        tmux -2
    else
        tmux -2 new -s $1
    fi
}

function mxa() {
    # if arg provided
    if [[ ! -z $1 ]]; then  # If arg provided
        # if session with same name doesn't exist
        if [[ $(tmux list-sessions | cut -d':' -f1 | grep -c $1) -eq 0 ]]; then
            echo "creating new session $1 ..."
            tmux -2 new -s $1
        else
            tmux -2 attach -t $1
        fi
    else
        # if tmux is running
        if [[ ! -z $(ps aux | grep \ Ss\ | grep tmux) ]]; then
            tmux -2 attach
        else
            echo "tmux wasn't running. Creating new session without a name..."
            sleep 1
            tmux -2 new -s $1
        fi
    fi
}

alias mxl='tmux list-sessions'
alias mxd='tmux detach'

alias tmux='tmux -2'
