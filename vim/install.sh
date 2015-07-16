#!/bin/sh

VIMDIR="${HOME}/.vim"
VIMRC="${VIMDIR}/vimrc"
BUNDLE="${VIMDIR}/bundle"
CONF="${VIMDIR}/config"
LANGUAGE="${VIMDIR}/specif"
ROOTDIR="$(readlink -f "$(dirname $0)")"

SYMBOLIC=0

DEPLIST="git vim-l9 cmake python2 idutils clang"
VIMLIST="vim gvim"

# Warning: this script run for Archlinux or any distros that use pacman
#          as package manager
check_deps()
{
    pacman -Q "$1"
    return $?
}


install_prerequisities()
{
    error=0
    foundvim=0
    for pkg in ${VIMLIST}; do
        if check_deps "${pkg}"; then
            echo "Found ${pkg}"
            foundvim=1
        fi
    done
    for pkg in ${DEPLIST}; do
        if ! check_deps "${pkg}"; then
            echo "You need to install '${pkg}' package."
            error=1
        fi
    done

    if [ ${foundvim} -eq 0 ]; then
        echo "You need to install vim to apply Vim configuration"
        exit 127
    fi
    if [ ${error} -eq 1 ]; then
        exit 127
    fi
}

install_plugin_from_git()
{
    url="$1"
    name="$2"

    if [ -d "${BUNDLE}/${name}" ]; then
        (cd "${BUNDLE}/${name}" && git pull origin master)
        (cd "${BUNDLE}/${name}" && git submodule update --recursive)
    else
        (cd "${BUNDLE}" && git clone "${url}" "${name}")
        (cd "${BUNDLE}/${name}" && git submodule update --init --recursive)
    fi
}

usage()
{
    echo "VIM installation script"
    echo "-----------------------"
    echo ""
    echo "$0 [OPTIONS]"
    echo ""
    echo "-s, --symbolic"
    echo "        Install configuration using symbolic links."
    echo "-h, --help"
    echo "        Show this help and quit"
}

while [ $# -ne 0 ]; do
    case "$1" in
        "--symbolic"|"-s")
            SYMBOLIC=1
            ;;
        "--help"|"-h")
            usage
            exit 0
            ;;
        *)
            echo "Unrecognized argument. ($1)"
            usage
            exit 127
            ;;
    esac
    shift
done

install_prerequisities

# Init global vim structure
mkdir -p "${VIMDIR}/autoload"
mkdir -p "${BUNDLE}"

if [ ${SYMBOLIC} -eq 1 ]; then
    ln -svf "$(readlink -f "${ROOTDIR}/vimrc")" "${VIMRC}"
else
    cp -Rvf "${ROOTDIR}/vimrc" "${VIMRC}"
fi

ln -sf "${VIMRC}" "${HOME}/.vimrc"

# Install pathogen plugin
if [ -d "${VIMDIR}/pathogen" ]; then
    (cd "${VIMDIR}/pathogen" && git pull origin master)
else
    git clone https://github.com/tpope/vim-pathogen.git "${VIMDIR}/pathogen"
    (cd "${VIMDIR}/autoload" && ln -s "../pathogen/autoload/pathogen.vim" .)
fi

# Install NERDTree plugin (to navigate in folder tree)
install_plugin_from_git "https://github.com/scrooloose/nerdtree.git" "nerdtree"
# Install FuzzyFinder (to find anything, anywhere)
install_plugin_from_git "https://github.com/vim-scripts/FuzzyFinder.git" "fuzzyfinder"
# Install Fugitive (to do all git in vim)
install_plugin_from_git "https://github.com/tpope/vim-fugitive.git" "fugitive"
# Install vim-git (to get better vim color when using git)
install_plugin_from_git "https://github.com/tpope/vim-git.git" "vimgit"
# Install tagbar (to get all tags)
install_plugin_from_git "https://github.com/majutsushi/tagbar.git" "tagbar"
# Install syntastic (to statically check syntax)
install_plugin_from_git "https://github.com/scrooloose/syntastic.git" "syntastic"
# Install ultisnips (to manage snippets)
install_plugin_from_git "https://github.com/SirVer/ultisnips.git" "ultisnips"
# Install YouCompleteMe (to add autocomplete)
install_plugin_from_git "https://github.com/Valloric/YouCompleteMe.git" "youcompleteme"
# Compile YouCompleteMe plugin
(cd "${BUNDLE}/youcompleteme" && ./install.sh --clang-completer --omnisharp-completer --gocode-completer)
# Install delimitMate (to automatically close bracket)
install_plugin_from_git "https://github.com/Raimondi/delimitMate.git" "delimitmate"
# Install colorizer (to color background of html color)
install_plugin_from_git "https://github.com/vim-scripts/colorizer.git" "colorizer"
# Install vim-matchit (to easely navigate from one bracket to another)
install_plugin_from_git "https://github.com/edsono/vim-matchit.git" "matchit"
# Install NERDCommenter (to comment or uncomment large part of code)
install_plugin_from_git "https://github.com/scrooloose/nerdcommenter.git" "nerdcommenter"
# Install Tabular (to produce wonderfull array)
install_plugin_from_git "https://github.com/godlygeek/tabular.git" "tabular"
# Install nextval (to increment/decrement absolutely everything)
install_plugin_from_git "https://github.com/vim-scripts/nextval.git" "nextval"
# Install surround (to encapsulate piece of text)
install_plugin_from_git "https://github.com/tpope/vim-surround.git" "surround"

# Install bepo mapping
if [ ${SYMBOLIC} -eq 1 ]; then
    ln -svf "$(readlink -f "${ROOTDIR}/config")" "${CONF}"
    ln -svf "$(readlink -f "${ROOTDIR}/specif")" "${LANGUAGE}"
else
    cp -Rvf "${ROOTDIR}/config" "${CONF}"
    cp -Rvf "${ROOTDIR}/specif" "${LANGUAGE}"
fi


# Easy Diff goto
#noremap <unique> <C-Up> [c
#noremap <unique> <C-s> [c
#noremap <unique> <C-Down> ]c
#noremap <unique> <C-t> ]c

#""" Mutt
#augroup filetypedetect
#    autocmd BufRead,BufNewfile *mutt-*  setfiletype mail
#augroup END


#map <F7> :setlocal spell! spelllang=fr,en<CR>
#map <F6> :set expandtab!<CR>
