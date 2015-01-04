alias tmux='TERM=xterm-256color tmux'

function mx() {
    if [ -z $1]; then
        TERM=xterm-256color tmux
    else
        TERM=xterm-256color tmux new -s $1
    fi
}

function mxa() {
    if [ -z $1 ]; then
        TERM=xterm-256color tmux attach
    else
        TERM=xterm-256color tmux attach -t $1
    fi
}

alias mxl='tmux list-sessions'
