# Funest's .bashrc
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines nor lines starting with space in the history.
HISTCONTROL=ignoreboth

# history: appended, bigger
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=3000

# update size of window, because resizing happens
shopt -s checkwinsize

# mad globs
shopt -s globstar

# my prompt
PS1='\[\033[0;34m\]\u@\h\[\033[00m\]:\[\033[0;36m\]\w\[\033[00m\]\$ '

# set title to user:dir
PS1="\[\e]0;\u:\w\a\]$PS1"


# my aliases
source $HOME/.shellaliases
# fix autocomplete on dots alias:
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main dots

# bash_completion
source /usr/share/bash-completion/bash_completion

export EDITOR=nvim # o_o :wq
