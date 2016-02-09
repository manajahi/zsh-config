# fortune cookie stuff
FORTUNE="/usr/games/fortune"
FORTUNE_OPTS=(debian-hints programming literature)
COWSAY="/usr/games/cowsay"

# Only for a normal user in the console, make the cow say a fortune *g*
if [ "$UID" != 0 ] && [ ! "${DISPLAY}" ]; then
        if [ -x ${COWSAY} ]; then
                if [ -x ${FORTUNE} ]; then
                        ${FORTUNE} ${FORTUNE_OPTS} | ${COWSAY} -nW80; echo
                fi
        elif [ -x ${FORTUNE} ]; then
                ${FORTUNE} ${FORTUNE_OPTS}; echo
        fi
fi


#forcing xmodmap
# if [ -n "${DISPLAY+x}" ]; then
#     xmodmap $HOME/.xmodmap
# fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
