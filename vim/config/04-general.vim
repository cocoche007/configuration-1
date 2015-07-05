" Redefine the shell redirection operator to receive both the stderr messages
" and stdout messages
set shellredir=>%s\ 2>&1

" keep 50 lines of command line history
set history=50

" default = 4000
set updatetime=1000

" auto read same-file change ( better for vc/vim change )
set autoread

" enlarge maxmempattern from 1000 to ... (2000000 will give it without limit)
set maxmempattern=1000

set mouse=a
