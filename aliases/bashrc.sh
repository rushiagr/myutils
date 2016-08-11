HISTSIZE=100000
HISTFILESIZE=200000
HISTIGNORE="*personal*:*secret*:cd*"

# Following lines do this:
#  - If the same command is entered again consecutively, store only one copy
#  - Save history after every command, so that even if the terminal
#    crashes/force-killed you have saved history. Note that the side-effect of
#    this is that if you execute a command in a terminal, it will be visible in
#    another simultaneously running terminal's history as soon as you execute
#    even one command in the new terminal
#  - If a command is entered which was previously typed in the past (but not
#    consecutively), remove all previous instances from history and add only one
#    new instance, effectively removing all duplicates from history, including
#    non-consecutive ones
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
