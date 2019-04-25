" direnv.vim - support for direnv <http://direnv.net>
" Author:       zimbatm <http://zimbatm.com/> & Hauleth <lukasz@niemier.pl>
" Version:      0.2

if exists('g:loaded_direnv') || &compatible || v:version < 700
  finish
endif
let g:loaded_direnv = 1

" MacVim (vim 8.0) with patches 1-1272 throws an error if a job option is given
" extra fields that it does not recognize. If the job ran even with the error
" message, this could be fixed with `silent!`, but the job doesn't run.
"
" To fix this, we give `vim` an empty `s:job` dictionary that calls back to the
" `s:job_status` dictionary. `nvim` gets `s:job` set as `s:job_status`.

command! -nargs=0 DirenvExport call direnv#export()

if direnv#auto()
  augroup direnv_rc
    au!
    autocmd VimEnter * DirenvExport

    if exists('##DirChanged')
      autocmd DirChanged * DirenvExport
    else
      autocmd BufEnter * DirenvExport
    endif
  augroup END
endif

" vi: fdm=marker sw=2 sts=2 et
