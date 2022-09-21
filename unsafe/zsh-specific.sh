autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Zsh history niceties. Source: https://www.soberkoder.com/better-zsh-history/
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTFILE=~/.zsh_history

setopt HIST_FIND_NO_DUPS
# following should be turned off, if sharing history via setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY


# If these lines are not added, files and directories both appear in same
# 'green' i.e. default color. After this is added, directories are light blue,
# and everything else is green / default color. If just the first export is
# kept, it still causes directories to take different colour, though that
# colour is dark blue, which doesn't go well with dark / black background.
# Also, just keeping the first export also makes executables go dark red, which
# is nice because it is yet another different colour, but it's still hard to
# read, so adding second line. Source: https://superuser.com/a/1584277
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
