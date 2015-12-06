# My Utilities

This is a repository of all the shortcuts I have created over time using
Linux shells.

The shortcuts are either shell aliases or functions.

I created these aliases for commands I was using very frequently. The focus was on reducing the number of keystrokes. For example, I found myself doing 'git push origin master' quite a lot of times, so I created `gpom`. Care has been taken to not mask any existing aliases/commands of Bash shell.

I work mostly on bash shell on Ubuntu, and I have not tested commands on any other OS/shell, except a little bit on OS X 10.10.

## Installation


```
./install-aliases.sh
```

This will create a file `~/.aliasrc` and add all the aliases and functions in this file. Also, it will add `source ~/.aliasrc` to `~/.bashrc` so that all your aliases are ready to be used whenever you open a new terminal session.

### Some very commonly used shortcuts

git push origin master
