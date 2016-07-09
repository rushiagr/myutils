# Set Go variables if Go is installed
if [[ $(which go | grep -c bin) == 1 ]]; then
    export GOPATH=$HOME/src/go
    export PATH=$PATH:$GOPATH/bin
fi

#NOTE: only installs old 1.2 version golang
function install_golang_ubuntu_trusty() {
    # Install golang
    sudo apt-get install golang

    # Create a nice directory structure for dev env
    mkdir -p $HOME/src/go
    mkdir -p $GOPATH/{src,bin,pkg}
    mkdir -p $GOPATH/src/github.com

    # Update path variable
    export GOPATH=$HOME/src/go
    export PATH=$PATH:$GOPATH/bin

    # Syntax highlighting
    sudo apt-get install vim-gocomplete gocode vim-syntax-go
    vim-addon-manager install go-syntax
    vim-addon-manager install gocode
}
