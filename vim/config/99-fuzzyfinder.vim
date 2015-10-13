noremap <C-o> :FufBuffer<CR>
noremap <C-n> :FufFile<CR>
" List file from filter
" noremap <C-c> call fuf#setOneTimeVariables([
"                           'g:fuf_coveragefile_globPatterns', ['**/*.h',
"                                                               '**/c']
"                           ]) \| FufCoverageFile<CR>
"
noremap <C-d> :FufDir<CR>
" Most recently used
noremap <C-m> :FufMruFile<CR>
noremap <C-!> :FufMruCmd<CR>
"noremap <C-> :FufBookmarkFile<CR>
"noremap <C-> :FufBookmarkDir<CR>
nnoremap <silent> <C-]> :FufBufferTagAllWithCursorWord!<CR>
vnoremap <silent> <C-]> :FufBufferTagAllWithSelectedText!<CR>
noremap <C-)> :FufJumpList<CR>
noremap <C-(> :FufChangeList<CR>
noremap <C-l> :FufLine<CR>
"noremap <C-s> :FufQuickfix<CR>

