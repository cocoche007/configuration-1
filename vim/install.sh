#!/bin/sh

INSTALL_DIR=$(dirname $0)

installfile()
{
    if [ -f "$2" ]; then
        if [ "x$3" != "x" ]; then
            answer=$3
        else
            echo "Warning, $2 file already exists."
            diff "$1" "$2"
            echo -n "(R)eplace, (M)erge, (S)kip? [R/m/s]"
            read answer
        fi
        case "$answer" in
            "M"|"m")
                echo "Manually merge $1 and $2"
                vimdiff "$1" "$2"
                ;;
            "S"|"s")
                ;;
            "R"|"r"|*)
                if [ ! -d "$(dirname "$2")" ]; then
                    mkdir -p "$(dirname "$2")"
                fi
                cp -v "$1" "$2"
        esac
    else
        if [ ! -d "$(dirname "$2")" ]; then
            mkdir -p "$(dirname "$2")"
        fi
        cp -v "$1" "$2"
    fi
}

installdir()
{
    if [ -d "$2" ]; then
        echo "Warning, $2 folder already exists."
        diff -r "$1" "$2"
        echo -n "(R)eplace all, (M)erge all, (S)kip all, (I)nteractive? [R/m/s/i]"
        read answer
        case "$answer" in
            "M"|"m")
                flag="M"
                ;;
            "S"|"s")
                return
                ;;
            "I"|"i")
                flag=""
                ;;
            "R"|"r"|*)
                flag="R"
                ;;
        esac
        for file in $(find "$1" -type f); do
            outfile=$(echo "$file" | sed "s|$1|$2|")
            installfile "$file" "$outfile" $flag
        done
    else
        cp -Rvf "$1" "$2"
    fi
}

installfile "$INSTALL_DIR/vimrc"    "$HOME/.vimrc"
installdir  "$INSTALL_DIR/vim"	    "$HOME/.vim"
installdir  "$INSTALL_DIR/toolkit"  "$HOME/.toolkit"
[ ! -d "$HOME/.exdev" ] && mkdir "$HOME/.exdev"


