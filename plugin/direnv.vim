" direnv.vim - support for direnv <http://direnv.net>
" Author:       zimbatm <http://zimbatm.com/>
" Version:      0.1

if exists("g:loaded_direnv") || &cp || v:version < 700
  finish
endif
let g:loaded_direnv = 1

command! -nargs=0 DirenvExport call <SID>DirenvExport ()

function! s:DirenvExport()
  if filereadable('.envrc')
    " FIXME: vim seems to read both stdout and stderr, it would be nice to
    "        display stderr in a buffer on error
    execute system('direnv export vim 2>/dev/null')
  endif
endfunction

" TODO: Execute DirenvExport on load
" TODO: Execute DirenvExport when the PWD changes
"       vim doesn't have a chdir event unfortunately

if has("autocmd")
  augroup direnv
    autocmd VimEnter * call s:DirenvExport()
    autocmd BufEnter * call s:DirenvExport()
  augroup END

  autocmd BufRead,BufNewFile .envrc set filetype=sh
endif

" vim:set ft=vim sw=2 sts=2 et:
