#!/bin/sh

VIMDIR="${HOME}/.vim"
VIMRC="${VIMDIR}/vimrc"
BUNDLE="${VIMDIR}/bundle"
CONF="${VIMDIR}/config"
LANGUAGE="${VIMDIR}/specif"
ROOTDIR="$(readlink -f "$(dirname $0)")"

SYMBOLIC=0

DEPLIST="git cmake python2 idutils clang tidy-html5"
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

# Install Vim-L9 plugin
install_plugin_from_git "https://github.com/vim-scripts/L9" "vim-l9"
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
# Install wmgraphviz (to manipulate gv graph)
install_plugin_from_git "https://github.com/wannesm/wmgraphviz.vim.git" "wmgraphviz"
# Install vim-airline (to get better line status)
install_plugin_from_git "https://github.com/bling/vim-airline.git" "vim-airline"

# Install bepo mapping
if [ ${SYMBOLIC} -eq 1 ]; then
    [ ! -s ${CONF} ] && ln -svf "$(readlink -f "${ROOTDIR}/config")" "${CONF}"
    [ ! -s ${LANGUAGE} ] && ln -svf "$(readlink -f "${ROOTDIR}/specif")" "${LANGUAGE}"
else
    [ ! -d ${CONF} ] && cp -Rvf "${ROOTDIR}/config" "${CONF}"
    [ ! -d ${LANGUAGE} ] && cp -Rvf "${ROOTDIR}/specif" "${LANGUAGE}"
fi

for patch in $(find "${ROOTDIR}/patch/" -type f); do
    base=$(basename "${patch}")
    plugin=$(echo "${base}" | sed 's|\.patch||')
    if [ -d "${BUNDLE}/${plugin}" ]; then
        (cd "${BUNDLE}/${plugin}" && git apply "${patch}")
    fi
done

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
