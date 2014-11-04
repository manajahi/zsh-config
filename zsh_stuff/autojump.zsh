if [ $commands[autojump] ]; then # check if autojump is installed
    if [ -f /usr/share/autojump/autojump.zsh ]; then
	source /usr/share/autojump/autojump.zsh
    fi  
fi