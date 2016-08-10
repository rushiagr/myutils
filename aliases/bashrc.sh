HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTIGNORE="*personal*:*secret*:cd*"

# After every command, save history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
