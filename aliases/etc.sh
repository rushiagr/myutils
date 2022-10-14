# C-w to erase upto last '/' character, and not till last whitespace
stty werase undef
bind '\C-w:unix-filename-rubout'

# After adding this line, I can type '!!' and press space to see what was the
# last command I ran.
bind Space:magic-space

# Start showing matches immediately after pressing tab, instead of pressing tab
# twice
bind "set show-all-if-ambiguous on"

# Adding this enables reverse reverse search in terminal, on mac
stty -ixon

# Changes color of directories in output of 'ls' from blue to green color. That
# way it's more readable with f.lux on. Seems to not work on macs, but works
# fine with Linux machines
# Source: https://askubuntu.com/a/466203/76941
LS_COLORS=$LS_COLORS:'di=0;32:' ; export LS_COLORS
