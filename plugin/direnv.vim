" direnv.vim - support for direnv <http://direnv.net>
" Author:       zimbatm <http://zimbatm.com/> & Hauleth <lukasz@niemier.pl>
" Version:      0.2

if exists('g:loaded_direnv') || &cp || v:version < 700
  finish
endif
let g:loaded_direnv = 1

command! -nargs=0 DirenvExport call direnv#export()

augroup envrc
  au!
  autocmd BufRead,BufNewFile .envrc set filetype=sh
  autocmd BufWritePost .envrc DirenvExport
  autocmd VimEnter * DirenvExport

  if exists('##DirChanged')
    autocmd DirChanged * DirenvExport
  else
    autocmd BufEnter * DirenvExport
  endif
augroup END

" vi: fdm=marker sw=2 sts=2 et
