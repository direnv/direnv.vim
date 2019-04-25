" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

augroup direnv-buffer
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> DirenvExport
augroup END
