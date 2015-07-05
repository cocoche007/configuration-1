" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
" do incremental searching
set incsearch
" Set smartcase mode on, If there is upper case character in the search patern,
" the 'ignorecase' option will be override.
set smartcase
