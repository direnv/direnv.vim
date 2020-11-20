" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

let s:direnv_edit_mode = get(g:, 'direnv_edit_mode', 'edit')

function! direnv#edit#envrc() abort
  if $DIRENV_DIR !=# ''
    let l:envrc_dir = substitute($DIRENV_DIR, '^-', '', '')
  else
    let l:envrc_dir = getcwd()
  endif
  let l:envrc = l:envrc_dir . '/.envrc'
  if !filereadable(l:envrc)
    echom 'new .envrc file will be created:' l:envrc_dir
  endif
  call direnv#edit#execute(l:envrc)
endfunction

function! direnv#edit#direnvrc() abort
  if $XDG_CONFIG_HOME ==# ''
    let l:direnvrc_dir = $HOME . '/.config/direnv'
  else
    let l:direnvrc_dir = $XDG_CONFIG_HOME . '/direnv'
  endif
  if filereadable(l:direnvrc_dir . '/direnvrc')
    let l:direnvrc = l:direnvrc_dir . '/direnvrc'
  elseif filereadable($HOME . '/.direnvrc')
    let l:direnvrc = $HOME . '/.direnvrc'
  else
    let l:direnvrc = l:direnvrc_dir . '/direnvrc'
    if !isdirectory(l:direnvrc_dir)
      let l:result = direnv#edit#mkdir(l:direnvrc_dir)
      if !l:result
        echoerr 'Vim cannot create the directory:' l:direnvrc_dir
        return
      endif
    endif
  endif
  if !filereadable(l:direnvrc)
    echom 'new direnvrc file will be created:' l:direnvrc
  endif
  call direnv#edit#execute(l:direnvrc)
endfunction

function! direnv#edit#mkdir(dir) abort
  if !exists('*mkdir')
    return 0
  endif
  let l:result = mkdir(a:dir, 'p', 0700)
  return l:result
endfunction

function! direnv#edit#execute(file) abort
  execute ':' . s:direnv_edit_mode a:file
endfunction
