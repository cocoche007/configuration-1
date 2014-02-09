#!/bin/sh

INSTALL_DIR=$(dirname $0)

installfile()
{
    if [ -f "$2" ]; then
        if [ "x$4" != "x" ]; then
            answer=$4
        else
            echo "Warning, $2 file already exists."
            diff "$1" "$2"
            echo -n "(R)eplace, (M)erge, (S)kip? [R/m/s]"
            read answer
        fi
        case "$answer" in
            "M"|"m")
                echo "Start vimdiff to manual merge $1 to $2"
                $3 vimdiff "$1" "$2"
                ;;
            "S"|"s")
                ;;
            "R"|"r"|*)
                $3 cp -v "$1" "$2"
        esac
    else
        if [ -d "$(dirname "$2")" ]; then
            $3 mkdir -p "$(dirname "$2")"
        fi
        $3 cp -v "$1" "$2"
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
            installfile "$file" "$outfile" "$3" $flag
        done
    else
        cp -Rvf "$1" "$2"
    fi
}

installfile "$INSTALL_DIR/Xresources"    "$HOME/.Xresources"
installfile "$INSTALL_DIR/config"        "$HOME/.i3/config"
installfile "$INSTALL_DIR/i3status.conf" "$HOME/.i3status.conf"
installfile "$INSTALL_DIR/xinitrc"       "$HOME/.xinitrc"
installfile "$INSTALL_DIR/keyboard.sh"   "/etc/profile.d/keyboard.sh" "sudo"
installfile "$INSTALL_DIR/XCompose"      "$HOME/.XCompose"
