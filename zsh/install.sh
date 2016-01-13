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
                vimdiff "$1" "$2"
                ;;
            "S"|"s")
                ;;
            "R"|"r"|*)
                cp -v "$1" "$2"
        esac
    else
        if [ -d "$(dirname "$2")" ]; then
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

testshell()
{
    if [ "x$SHELL" != "x$1" ]; then
        if [ ! -x "$1" ]; then
            echo "Z-shell is not installed on your system"
            echo "(or not in a standard place /bin/zsh)."
            echo "Please try:"
            echo "    pacman -S zsh"
            echo "    apt-get install zsh"
            echo "    yum install zsh"
        else
            echo "Your current shell is set to ${SHELL}."
            echo -n "Change to Z-shell? [Y/n]"
            read answer
            case "$answer" in
                "N"|"n")
                    ;;
                "Y"|"y"|*)
                    chsh -s "$1" "$USER"
                    ;;
            esac
        fi
    fi
    echo "To enable dynamic syntax highlighting, please install:"
    echo "zsh-syntax-highlighting"
}


installfile "$INSTALL_DIR/aliases" "$HOME/.aliases"
installfile "$INSTALL_DIR/zshrc"   "$HOME/.zshrc"
installdir  "$INSTALL_DIR/zsh"       "$HOME/.zsh"
testshell   "/bin/zsh"


