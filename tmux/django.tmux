cd ~/src/rr

tmux new-session -d -s x -n x
cd templates/app
tmux new-window -t x:2 -n tpl
cd ../../app
tmux new-window -t x:3 -n vw
tmux new-window -t x:4 -n db
tmux new-window -t x:5 -n mys
tmux new-window -t x:6 -n url
tmux new-window -t x:7 -n etc
