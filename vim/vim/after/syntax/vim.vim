" ======================================================================================
" File         : vim.vim
" Author       : Wu Jie 
" Last Change  : 10/21/2008 | 22:48:48 PM | Tuesday,October
" Description  : 
" ======================================================================================

"/////////////////////////////////////////////////////////////////////////////
" syntax defines
"/////////////////////////////////////////////////////////////////////////////

if !exists('g:Ex_todo_keyword')
    let g:Ex_todo_keyword = 'NOTE REF EXAMPLE'
endif
if !exists('g:Ex_comment_lable_keyword')
    let g:Ex_comment_lable_keyword = 'TEMP CRASH MODIFY DEBUG DUMMY DELME TESTME OPTME REFACTORING DUPLICATE REDUNDANCY'
endif
silent exec ':syn keyword vimTodo contained ' . g:Ex_todo_keyword
silent exec ':syn keyword exCommentLable contained ' . g:Ex_comment_lable_keyword
syn cluster vimCommentGroup	contains=vimTodo,exCommentLable,@Spell

"/////////////////////////////////////////////////////////////////////////////
" finish
"/////////////////////////////////////////////////////////////////////////////

let b:current_syntax = "vim"
" vim:ts=18  fdm=marker

