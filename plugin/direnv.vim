" direnv.vim - support for direnv <http://direnv.net>
" Author:       zimbatm <http://zimbatm.com/>
" Version:      0.1

if exists("g:loaded_direnv") || &cp || v:version < 700
  finish
endif
let g:loaded_direnv = 1

command! -nargs=0 DirenvExport call <SID>DirenvExport ()

function! s:DirenvExport()
  " FIXME: vim seems to read both stdout and stderr
  execute system('direnv export vim 2>/dev/null')
endfunction

" TODO: Execute DirenvExport on load
" TODO: Execute DirenvExport when the PWD changes

augroup direnv
  autocmd VimEnter * call s:DirenvExport()
  autocmd BufEnter * call s:DirenvExport()
augroup END

" vim:set ft=vim sw=2 sts=2 et:
