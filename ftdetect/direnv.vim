" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

autocmd BufRead,BufNewFile .envrc,~/.config/direnv/direnvrc,~/.direnvrc setfiletype direnv
