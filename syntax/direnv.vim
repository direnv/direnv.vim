" direnv.vim - support for direnv <http://direnv.net>
" Author:       JINNOUCHI Yasushi <me@delphinus.dev>
" Version:      0.2

if exists('b:current_syntax')
  finish
endif

" To use syntax for bash in sh.vim, set the g:is_bash value temporarily.
let s:current = get(g:, 'is_bash', '__NO_VALUE__')
let g:is_bash = 1
runtime! syntax/sh.vim
if s:current ==# '__NO_VALUE__'
  unlet g:is_bash
else
  let g:is_bash = s:current
endif
unlet s:current

let b:current_syntax = 'direnv'

" Func: with commands {{{
" `has` func takes one argument that represents a CLI command.
syn keyword direnvCommandFunc has nextgroup=direnvCommand,shSingleQuote,shDoubleQuote skipwhite
hi def link direnvCommandFunc shStatement

" command name is almost the same as direnvPath, but has a different color.
syn region direnvCommand start=/[^'"[:space:]]/ skip=/\\./ end=/\([][(){}#`'";\\[:space:]]\)\@=\|$/ contained nextgroup=shComment skipwhite
hi def link direnvCommand shCommandSub
" }}}

" Func: with paths {{{
" These funcs takes one argument that represents a file/dir path.
syn keyword direnvPathFunc dotenv user_rel_path find_up source_env source_up PATH_add MANPATH_add load_prefix watch_file nextgroup=direnvPath,shSingleQuote,shDoubleQuote skipwhite
hi def link direnvPathFunc shStatement

" path string can end before non-escaped [, ], (, ), {, }, #, `, ', ", ;, \, and spaces.
syn region direnvPath start=/[^'"[:space:]]/ skip=/\\./ end=/\([][(){}#`'";\\[:space:]]\)\@=\|$/ contained nextgroup=shComment skipwhite
hi def link direnvPath Directory

" `expand_path` takes one or two arguments that represents a dir path.
syn keyword direnvExpandPathFunc expand_path nextgroup=direnvExpandPathRel,shSingleQuote,shDoubleQuote skipwhite
hi def link direnvExpandPathFunc shStatement

syn region direnvExpandPathRel start=/[^'"[:space:]]/ skip=/\\./ end=/\%(\s\|\_$\)/ contained nextgroup=direnvPath,shSingleQuote,shDoubleQuote skipwhite
hi def link direnvExpandPathRel Directory

" `path_add` takes two arguments that represents a variable name and a dir
" path.
syn keyword direnvPathAddFunc path_add nextgroup=direnvVar skipwhite
hi def link direnvPathAddFunc shStatement

syn match direnvVar /\S\+/ nextgroup=direnvPath,shSingleQuote,shDoubleQuote contained skipwhite
hi def link direnvVar shCommandSub
" }}}

" Func: use {{{
syn keyword direnvUseFunc use nextgroup=direnvUseCommand skipwhite
hi def link direnvUseFunc shStatement

" `use rbenv/nix/guix` takes several arguments.
syn match direnvUseCommand /\S\+/ contained
hi def link direnvUseCommand shCommandSub
" }}}

" Func: layout {{{
" `layout` takes one argument that represents a language name.
syn keyword direnvLayoutFunc layout nextgroup=direnvLayoutLanguage,direnvLayoutLanguagePath skipwhite
hi def link direnvLayoutFunc shStatement

syn keyword direnvLayoutLanguage go node perl python3 ruby contained
hi def link direnvLayoutLanguage shCommandSub

" `layout python` takes one more argument that represents a file path.
syn keyword direnvLayoutLanguagePath python nextgroup=direnvPath,shSingleQuote,shDoubleQuote contained skipwhite
hi def link direnvLayoutLanguagePath shCommandSub
" }}}

" Func: others {{{
" `direnv_load` takes several arguments.
syn keyword direnvFunc direnv_load
hi def link direnvFunc shStatement
" }}}

syn cluster direnvStatement contains=direnvCommandFunc,direnvPathFunc,direnvExpandPathFunc,direnvPathAddFunc,direnvUseFunc,direnvLayoutFunc,direnvFunc
syn cluster shArithParenList add=@direnvStatement
syn cluster shCommandSubList add=@direnvStatement

" vim:se fdm=marker:
