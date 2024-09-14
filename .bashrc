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
_ps1_prompt () {
    # Return value
    RETVALUE=$?
    if [ $RETVALUE -ne 0 ]; then
        PS1_RETURN="$RETVALUE"
    else
        PS1_RETURN=
    fi

    # Prompt element(s)
    CURR_DIR=${PWD/#\/home\/funest/\~}

    # Colorless prompt, for width information
    COLORLESS_LEFT="$USER@$HOSTNAME:$CURR_DIR"
    WIDTH="$(($COLUMNS - ${#COLORLESS_LEFT}))"

    # Colors
    GREEN_FG=$(tput setaf 2)
    MAGENTA_FG=$(tput setaf 5)
    CYAN_FG=$(tput setaf 6)
    RED_FG=$(tput setaf 1)
    NORMAL_FG=$(tput sgr0)

    # Print prompt
    # Left
    printf "$GREEN_FG%s$NORMAL_FG@$MAGENTA_FG%s$NORMAL_FG:$CYAN_FG%s"\
        "$USER" "$HOSTNAME" "$CURR_DIR"
    # Right
    printf "$RED_FG%${WIDTH}s$NORMAL_FG" "$PS1_RETURN"
    # Second line
    printf "\n\$ "
}
PS1='$(_ps1_prompt)'

# my aliases
source $HOME/.shellaliases

# bash_completion
source /usr/share/bash-completion/bash_completion
_xfunc git __git_complete dots __git_main # Fix alias completion

export EDITOR=nvim # o_o :wq
