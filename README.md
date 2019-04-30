direnv.vim - yup
================

This plugin aim is to integrate [Direnv][direnv] and [Vim][vim]. Because Vim can
shell out to other tools it's nice if the environment is in sync with the usual
shell.

It also adds syntax highlighting for `.envrc` files.

Features
--------

* Direnv environment loading
* filetype & syntax highlighting for `.envrc` files
* Asynchronous running of Direnv command which won't delay your workflow.
  Supported in Vim 8 (with `job` and `channel`) or NeoVim.
* Add commands to edit `direnvrc` or `.envrc`'s.

Commands
--------

### `DirenvExport`

Run the Direnv command and load the valid settings. This command will be
executed automatically (and asynchronously) by `autocmd` events, so you need
not to run this explicitly.

#### `g:direnv_auto`

It will not execute `DirenvExport` automatically if `let g:direnv_auto
= 0`. The default value is `1`.

### `EditDirenvrc`

Open the global setting file for the Direnv command. This searches files
ordered below.

- `$XDG_CONFIG_HOME/direnv/direnvrc`
- `~/.config/direnv/direnvrc`
- `~/.direnvrc`

### `EditEnvrc`

Open the detected `.envrc` if found or a new buffer to edit `.envrc` on the
current directory.

#### `g:direnv_edit_mode`

Select the command to open buffers to edit. The default value is `'edit'`.

```vim
" split the window before editing files
let g:direnv_edit_mode = 'split'
" split vertically
let g:direnv_edit_mode = 'vsplit'
```

Limitations
-----------

The Vimscript syntax seems to limit keys to alphanumeric characters. If any
environment variable key is something different the plugin might fail.

The newer Vim builds (>8.0.1459) & [NeoVim][neovim] have auto command event
that is fired on directory changes, named: `DirChanged`. Thanks to that Direnv
will be fired only on `VimEnter` (as entering Vim isn't directory change) and
on `DirChanged`.

For older Vim's there is fallback that run on each `BufEnter` (not ideal
solution, but for now we have no other option).

Due to asynchronous calls to Direnv if you work too fast then it can happen that
variables from `.envrc` will not be yet loaded. However highly unlikely you are
so fast.

Install
-------

Then install the plugin.
With [Pathogen](https://github.com/tpope/vim-pathogen)

```
git clone https://github.com/direnv/direnv.vim.git ~/.vim/bundle/direnv.vim
```

and restart.

Configuration
-------------

To stop direnv.vim echoing the direnv output:

```viml
let g:direnv_silent_load = 1
```

TODO
----

- Allow/deny authorization mechanism.
- Add proper Vim documentation.

My Vimscript skill is tangent to zero, feedback is welcome
<https://github.com/direnv/direnv.vim>

[direnv]: https://direnv.net
[vim]: http://vim.org
[neovim]: https://neovim.io
