alias tmux='tmux'

function mx() {
    if [ -z $1]; then
        tmux
    else
        tmux new -s $1
    fi
}

function mxa() {
    if [ -z $1 ]; then
        tmux attach
    else
        tmux attach -t $1
    fi
}

alias mxl='tmux list-sessions'
