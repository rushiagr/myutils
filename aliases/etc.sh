# C-w to erase upto last '/' character, and not till last whitespace
stty werase undef
bind '\C-w:unix-filename-rubout'

# After adding this line, I can type '!!' and press space to see what was the
# last command I ran.
bind Space:magic-space

printf "qr "

# Start showing matches immediately after pressing tab, instead of pressing tab
# twice
bind "set show-all-if-ambiguous on"

# Adding this enables reverse reverse search in terminal, on mac
stty -ixon
