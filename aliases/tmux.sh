alias mx='tmux'

function mxa() {
    if [ -z $1 ]; then
        tmux attach
    else
        tmux attach -t $1
    fi
}

alias mxl='tmux list-sessions'
