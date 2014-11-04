#!/usr/bin/env zsh

precmd()
{
    PREV_RET_VAL=$?
    if [ $PREV_RET_VAL -ne 0 ]
    then
       	export PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}](%{$fg[magenta]%}$PREV_RET_VAL%{$reset_color%})$ "	    
   else    
	export PS1="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}]$ "	    
    fi
    
    ARRAY_CURRENT=(${(s:/:)PWD})
    case $TERM in
    xterm*)
        print -Pn "\e]0;$ARRAY_CURRENT[-3]/$ARRAY_CURRENT[-2]/$ARRAY_CURRENT[-1]\a"
        ;;
	rxvt*)
        print -Pn "\e]0;$ARRAY_CURRENT[-3]/$ARRAY_CURRENT[-2]/$ARRAY_CURRENT[-1]\a"

    esac
}