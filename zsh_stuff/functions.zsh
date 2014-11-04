#!/usr/bin/env zsh

# Create a directory and c file
function ctest()
{
    if (( $# == 0 ))
    then echo $0:" Missing directory name."
    else
	TARGET_DIR=$1
	TARGET_CFILE=$1.c
	mkdir $TARGET_DIR 
	cd $TARGET_DIR
	touch $TARGET_CFILE
	echo "#include<stdlib.h>" > $TARGET_CFILE
	echo "#include<stdio.h>\n\n" >> $TARGET_CFILE
	echo "int\nmain(void)\n{\n  return 0;\n}" >> $TARGET_CFILE
	eval ${EDITOR} $TARGET_CFILE
    fi
}

# Create a directory and scheme file
function atest()
{
    if (( $# == 0 ))
    then echo $0:" Missing directory name."
    else
	TARGET_DIR=$1
	mkdir $TARGET_DIR 
	cd $TARGET_DIR
	eval ${EDITOR}
    fi
}

# Create a directory like "year-month-day" (i. e. 2007-07-16)
function mdate()
{
    mkdir `date +%a_%d_%m_%Y`
    cd `date +%a_%d_%m_%Y`
}

# recursive ls
function lsrec() 
{
    if (( $# == 0 ))
    then ls -R . | awk '/:$/&&f{s=$0;f=0}/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}NF&&f{ print s"/"$0 }';
    else   
	ls -R "$*" | awk '/:$/&&f{s=$0;f=0}/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}NF&&f{ print s"/"$0 }';
    fi
}

# clean up directory
sweep() {
    FILES=(*~(N) .*~(N) \#*\#(N) *.core(N) *.cmo(N) *.cmi(N) .*.swp(N))
    NBFILES=${#FILES}
    if [[ $NBFILES > 0 ]]; then
        print $FILES
        local ans
        echo -n "Remove these files? [y/n] "
        read -q ans
        if [[ $ans == "y" ]]
        then
            rm ${FILES}
            echo "\n>> $PWD purged, $NBFILES files removed"
        else
            echo "\nOk. .. aborting .."
        fi
    fi
}

# Usage: simple-extract <file>
# Description: extracts archived files (maybe)
simple-extract () {
    if [[ -f $1 ]]
    then
        case $1 in
            *.tar.bz2)  bzip2 -v -d $1      ;;
            *.tar.gz)   tar -xvzf $1        ;;
            *.rar)      unrar $1            ;;
            *.deb)      ar -x $1            ;;
            *.bz2)      bzip2 -d $1         ;;
            *.lzh)      lha x $1            ;;
            *.gz)       gunzip -d $1        ;;
            *.tar)      tar -xvf $1         ;;
            *.tgz)      gunzip -d $1        ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *)          echo "'$1' Error. Please go away" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Usage: smartcompress <file> (<type>)
# Description: compresses files or a directory.  Defaults to tar.gz
smartcompress() {
    if [ $2 ]; then
        case $2 in
            tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
            tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
            tar.Z)          tar -Zcvf$1.$2 $1 ;;
            tar)            tar -cvf$1.$2  $1 ;;
            gz | gzip)      gzip           $1 ;;
            bz2 | bzip2)    bzip2          $1 ;;
            *)
                echo "Error: $2 is not a valid compression type"
                ;;
        esac
    else
        smartcompress $1 tar.gz
    fi
}

# Usage: show-archive <archive>
# Description: view archive without unpack
show-archive() {
    if [[ -f $1 ]]
    then
        case $1 in
            *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
            *.tar)         tar -tf $1 ;;
            *.tgz)         tar -ztf $1 ;;
            *.zip)         unzip -l $1 ;;
            *.bz2)         bzless $1 ;;
            *)             echo "'$1' Error. Please go away" ;;
        esac
    else
        echo "'$1' is not a valid archive"
    fi
}


# debian upgrade
upgrade () {
    if [ -z $1 ] ; then
        sudo apt-get update --yes
        sudo apt-get -u upgrade --yes
    else
        ssh $1 sudo apt-get update
        # ask before the upgrade
        local dummy
        ssh $1 sudo apt-get --no-act upgrade
        echo -n "Process the upgrade ?"
        read -q dummy
        if [[ $dummy == "y" ]] ; then
            ssh $1 sudo apt-get -u upgrade --yes
        fi
    fi
}

# prints the current system status
status() {
    print ""
    print "Date..: "$(date "+%Y-%m-%d %H:%M:%S")""
    print "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
    print "Term..: $TTY ($TERM), $BAUD bauds, $COLUMNS x $LINES cars"
    print "Login.: $LOGNAME (UID = $EUID) on $HOST"
    print "System: $(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)"
    print "Uptime:$(uptime)"
    print ""
}
