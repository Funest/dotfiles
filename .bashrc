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
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"

# update size of window, because resizing happens
shopt -s checkwinsize

# mad globs
shopt -s globstar

# prevent overwrites
set -o noclobber

# my prompt
# PS1='\[\033[0;34m\]\u@\h\[\033[00m\]:\[\033[0;36m\]\w\[\033[00m\]\n\$ '
_ps1_prompt () {
    ret=$?
    if [ $ret -ne 0 ]; then
        printf "[\e[0;31m$ret\e[0;0m] "
    fi
    printf "\n\$ "
}
_PS1_USER='\e[0;32m\]\u\e[0;0m\]'
_PS1_HOST='\e[0;35m\]\h\e[0;0m\]'
_PS1_PWD='\e[0;36m\]\w\e[0;0m\]'
PS1="$_PS1_USER@$_PS1_HOST:$_PS1_PWD	\$(_ps1_prompt)"

# my aliases
source $HOME/.shellaliases

# bash_completion
source /usr/share/bash-completion/bash_completion
_xfunc git __git_complete dots __git_main # Fix alias completion

export EDITOR=nvim # o_o :wq
