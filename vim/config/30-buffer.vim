" NOTE: ctags find the tags file from the current path instead of the path of current file
au BufNewFile,BufEnter * set cpoptions+=d
" ensure every file does syntax highlighting (full)
au BufEnter * :syntax sync fromstart
