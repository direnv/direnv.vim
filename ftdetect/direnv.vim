" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

autocmd BufRead,BufNewFile .envrc,.direnvrc,direnvrc setfiletype direnv
