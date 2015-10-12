" Open and close NERDTree with <F2>
noremap <unique> <F2> :NERDTreeToggle<CR>

" Close vim window if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Automatically start NERDTree if no file was specified at vim startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Set color according to extension in NERDTree
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd FileType NERDTree highlight ' . a:extension . ' ctermbg=' . a:bg . ' ctermfg=' . a:fg . ' guibg=' . a:guibg . ' guifg=' . a:guifg
    exec 'autocmd FileType NERDTree syn match ' . a:extension . ' #^\s\+.*' . a:extension . '$#'
endfunction

" I donot know why it does not work
call NERDTreeHighlightFile('pl', 'green', 'none', 'green', '#151515')

let NERDTreeMapActivateNode='o'
let NERDTreeMapOpenRecursively='O'
let NERDTreeMapCloseDir='x'
let NERDTreeMapCloseChildren='X'
let NERDTreeMapOpenSplit='h'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenExpl='e'
let NERDTreeMapJumpRoot='P'
let NERDTreeMapJumpParent='p'
let NERDTreeMapJumpFirstChild='É'
let NERDTreeMapChangeRoot='C'
let NERDTreeMapUpdir='u'
let NERDTreeMapUpdirKeepOpen='U'
let NERDTreeMapRefresh='a'
let MERDTreeMapRefreshRoot='A'
let NERDTreeMapMenu='m'
let NERDTreeMapChdir='cd'
let NERDTreeMapCWD='CD'
let NERDTreeMapToggleHidden='<C-h>'
let NERDTreeMapToggleFilters='f'
let NERDTreeMapToggleFiles='F'
let NERDTreeMapJumpLastChild='T'
let NERDTreeMapJumpNextSibling='<C-t>'
let NERDTreeMapJumpPrevSibling='<C-s>'
let NERDTreeMapOpenInTab='j'
let NERDTreeMapOpenInTabSilent='J'
