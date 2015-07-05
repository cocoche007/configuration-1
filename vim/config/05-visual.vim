" show matching paren
set showmatch

" 0 second to show the matching paren ( much faster )
set matchtime=0

" Show Line number
set nu

" minimal number of screen lines to keep above and below the cursor
set scrolloff=0

" I don't like wrap, cause in split window mode, it feel strange
set nowrap

" Set color scheme
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme elflord

" turn on wild menu, try typing :h and press <Tab>
set wildmenu

" display incomplete commands
set showcmd

" 1 screen lines to use for the command-line
set cmdheight=1

" show the cursor position all the time
set ruler

" allow to change buffer without saving
set hid

" shortens messages to avoid 'press a key' prompt
set shortmess=atI

" do not redraw while executing macros (much faster)
set lazyredraw

" for easy browse last line with wrap text
set display+=lastline

" always have status-line
set laststatus=2

" show tag with function protype.
set showfulltag

" Present the bottom scrollbar when the longest visible line exceen the window
set guioptions+=b

" disable menu & toolbar
set guioptions-=m
set guioptions-=T

" Show hiddn characters
highlight NbSp ctermbg=lightgray guibg=lightred
match NbSp /\%xa0/

set list
set lcs:trail:·,tab:»\ 
