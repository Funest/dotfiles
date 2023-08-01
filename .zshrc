# Funest's .zshrc

# PATH

PATH=$PATH:$HOME/.local/bin



# history - learn from it
setopt histignorealldups sharehistory
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=3000

# use emacs keybindings
bindkey -e

# completion magic I don't quite know
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# The following lines were added by compinstall
zstyle :compinstall filename '/home/funest/.zshrc'

autoload -Uz compinit && compinit
zmodload -i zsh/complist
# End of lines added by compinstall

# don't beep at me - but tell me when there are no matches
setopt nobeep nomatch


# my stuff: 
# aliases:
source $HOME/.shellaliases

export EDITOR=nvim # o_o :wq
export PAGER=less

# prompt
setopt promptsubst
PROMPT='%F{magenta}%n%f @ %F{blue}%M%f : %F{cyan}%~%f
%F{%0(?.green.red)}>%f '
RPROMPT='%0(?..%F{red}$?%f)'
PS2='> '

# set a title, helps me locate myself
function precmd () {
    echo -ne "\033]0;$USER:$(pwd | sed -e "s;^$HOME;~;")\a"
}

# because keys weren't working, idk
bindkey "^[[3~" delete-char             # Delete
bindkey "^[[7~" beginning-of-line       # Home
bindkey "^[[8~" end-of-line             # End
bindkey "^[[6~" end-of-history          # Page Down
bindkey "^[[5~" beginning-of-history    # Page Up

# search with arrows
autoload -U up-line-or-beginning-search 
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search 
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
