# Set Go variables if Go is installed
if [[ $(which go | grep -c bin) == 1 ]]; then
    export GOPATH=$HOME/src/go
    export PATH=$PATH:$GOPATH/bin
fi
