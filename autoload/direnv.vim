" direnv.vim - support for direnv <http://direnv.net>
" Author:       zimbatm <http://zimbatm.com/> & Hauleth <lukasz@niemier.pl>
" Version:      0.3

scriptencoding utf-8

let s:direnv_cmd = get(g:, 'direnv_cmd', 'direnv')
let s:direnv_interval = get(g:, 'direnv_interval', 500)
let s:direnv_max_wait = get(g:, 'direnv_max_wait', 5)
let s:direnv_auto = get(g:, 'direnv_auto', 1)
let s:job_status = { 'running': 0, 'stdout': [], 'stderr': [] }

if !exists('g:direnv_silent_load')
  let g:direnv_silent_load = 0
endif

function! direnv#auto() abort
  return s:direnv_auto
endfunction

function! direnv#post_direnv_load() abort
  call direnv#extra_vimrc#load()
  doautocmd User DirenvLoaded
endfunction

function! direnv#on_stdout(_, data, ...) abort
  if a:data != ['']
    call extend(s:job_status.stdout, a:data)
  end
endfunction

function! direnv#on_stderr(_, data, ...) abort
  if a:data != ['']
    call extend(s:job_status.stderr, a:data)
  end
endfunction

function! direnv#on_exit(_, status, ...) abort
  let s:job_status.running = 0

  if !g:direnv_silent_load
    for l:m in s:job_status.stderr
      if l:m isnot# ''
        echom l:m
      endif
    endfor
  endif
  exec join(s:job_status.stdout, "\n")
  call direnv#post_direnv_load()
endfunction

function! direnv#job_status_reset() abort
  let s:job_status['stdout'] = []
  let s:job_status['stderr'] = []
endfunction

function! direnv#err_cb(_, data) abort
  call direnv#on_stderr(0, split(a:data, "\n", 1))
endfunction

function! direnv#out_cb(_, data) abort
  call direnv#on_stdout(0, split(a:data, "\n", 1))
endfunction

function! direnv#exit_cb(_, status) abort
  call direnv#on_exit(0, a:status)
endfunction

if has('nvim')
  let s:job =
        \ {
        \   'on_stdout': 'direnv#on_stdout',
        \   'on_stderr': 'direnv#on_stderr',
        \   'on_exit': 'direnv#on_exit'
        \ }
else
  let s:job =
        \ {
        \   'out_cb': 'direnv#out_cb',
        \   'err_cb': 'direnv#err_cb',
        \   'exit_cb': 'direnv#exit_cb'
        \ }
endif

function! direnv#export() abort
  call s:export_debounced.do()
endfunction

function! direnv#export_core() abort
  if !executable(s:direnv_cmd)
    echom 'No Direnv executable, add it to your PATH or set correct g:direnv_cmd'
    return
  endif

  let l:cmd = [s:direnv_cmd, 'export', 'vim']
  if has('nvim')
    call jobstart(l:cmd, s:job)
  elseif has('job') && has('channel')
    if !has('timers')
      if s:job_status.running
        return
      endif
      let s:job_status.running = 1
    endif
    call direnv#job_status_reset()
    call job_start(l:cmd, s:job)
  else
    let l:tmp = tempname()
    echom system(printf(join(l:cmd).' '.&shellredir, l:tmp))
    exe 'source '.l:tmp
    call delete(l:tmp)
    call direnv#post_direnv_load()
  endif
endfunction

let s:export_debounced = {'id': 0, 'counter': 0}

if has('timers')
  function! s:export_debounced.call(...)
    let self.id = 0
    let self.counter = 0
    call direnv#export_core()
  endfunction

  function! s:export_debounced.do()
    call timer_stop(self.id)
    if self.counter < s:direnv_max_wait
      let self.counter = self.counter + 1
      let self.id = timer_start(s:direnv_interval, self.call)
    else
      call self.call()
    endif
  endfunction
else
  function! s:export_debounced.do()
    call direnv#export_core()
  endfunction
endif
