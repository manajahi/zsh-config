# Handle coloring
autoload -U colors && colors

# enable advanced globbing
setopt extendedglob

# enable files and directories strating with . to be globbed
setopt globdots

# no automatic correction
unsetopt correctall

# automatically cd into directories by calling them
setopt autocd
# to pushd visited directories
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups

autoload -U zmv 
alias mmv='noglob zmv -W'   # user-friendly version of zmv

# set these associated aliases:
autoload -U zsh-mime-handler 
autoload -U zsh-mime-setup 
autoload -U allopt 
autoload -U checkmail 
autoload -U colors 
autoload -U getjobs 
autoload -U harden 
autoload -U is-at-least 
autoload -U mere 
autoload -U promptnl 
autoload -U relative 
autoload -U tetris 
autoload -U zargs 
autoload -U zcalc 
autoload -U zed 
autoload -U zkbd 
autoload -U zrecompile 
autoload -U zstyle+ 

# Set up the prompt
autoload -Uz promptinit
promptinit

# my prompt
# export PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}]$ "

# Use emacs keybindings
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^@" set-mark-command

# # to tab backwards
bindkey '^[[Z' reverse-menu-complete

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000

# Global aliases
if [ -f $ZDOTDIR/.zsh_aliases ]; then
    source $ZDOTDIR/.zsh_aliases
fi

# Local aliases
if [ -f $ZDOTDIR/.zsh_local ]; then
    source $ZDOTDIR/.zsh_local
fi

# Load environement variables
if [ -f $ZDOTDIR/.zsh_env_variables ]; then
    source $ZDOTDIR/.zsh_env_variables
fi

# Miscs.
if [ -f $ZDOTDIR/.zsh_miscs ]; then
    source $ZDOTDIR/.zsh_miscs
fi

HISTFILE=$ZDOTDIR/.zsh_history
setopt histignorealldups sharehistory

# PATH for my completion stuff
fpath=($ZDOTDIR/completion $fpath)

# Autoload my completion stuff
autoload -U $ZDOTDIR/completion/*(:t)

# Use modern completion system
# My own completion files need to 
# be loaded before compinit
autoload -Uz compinit
compinit

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
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# to have the colors as output of ls
eval `dircolors ~/.dircolors`

# completion of apt-get
source /etc/zsh_command_not_found

#load my stuff
for file in $ZDOTDIR/zsh_stuff/*.zsh
source $file
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
