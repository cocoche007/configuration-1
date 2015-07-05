" F8:  Set Search pattern highlight on/off
nnoremap <unique> <F8> :let @/=""<CR>

" map Ctrl-Tab to switch window
nnoremap <unique> <S-Up> <C-W><Up>
nnoremap <unique> <S-Down> <C-W><Down>
nnoremap <unique> <S-Left> <C-W><Left>
nnoremap <unique> <S-Right> <C-W><Right>

" Move in fold
noremap <unique> z<Up> zk
noremap <unique> z<Down> zj

" Enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap <unique> « <gv
vnoremap <unique> » >gv

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <unique> <Up> gk
noremap <unique> <Down> gj

" Then when you put the cursor on or in a word, press "\sw", and
" the word will be swapped with the next word.  The words may
" even be separated by punctuation (such as "abc = def").
nnoremap <unique> <silent><leader>sw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
endif " has("autocmd")

