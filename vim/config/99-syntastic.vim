set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Force python3 checker
let g:syntastic_python_python_exec = '/usr/bin/python3'

" to enable perl checker
function! TogglePerlChecker()
    if exists('g:syntastic_enable_perl_checker') && g:syntastic_enable_perl_checker == 1
        let g:syntastic_enable_perl_checker = 0
    else
        let g:syntastic_enable_perl_checker = 1
    endif
endfunction

nmap <silent> <F3> :call TogglePerlChecker()<CR>
