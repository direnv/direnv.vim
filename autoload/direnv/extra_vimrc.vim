" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

" load() sources local vimrc's described in $EXTRA_VIMRC
function! direnv#extra_vimrc#load() abort
  let b:direnv_loaded_extra_vimrcs = get(b:, 'direnv_loaded_extra_vimrcs', {})
  if $DIRENV_EXTRA_VIMRC !=# ''
    for l:path in split($DIRENV_EXTRA_VIMRC, ':')
      if filereadable(l:path) && !has_key(b:direnv_loaded_extra_vimrcs, l:path)
        execute 'source' l:path
        let b:direnv_loaded_extra_vimrcs[l:path] = 1
      endif
    endfor
  endif
endfunction

" check() checks $DIRENV_DIR and call load() 
function! direnv#extra_vimrc#check() abort
  if $DIRENV_DIR !=# ''
    let l:filedir = expand('%:p:h')
    let l:direnv_dir = substitute($DIRENV_DIR, '^-', '', '')
    " TODO think about Windows?
    if stridx(l:filedir, l:direnv_dir) == 0
      call direnv#post_direnv_load()
    endif
  endif
endfunction
