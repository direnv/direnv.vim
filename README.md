direnv.vim - yup
================

STATUS: Experimental

This plugin's aim is to integrate direnv and vim. Because vim can shell out
to other tools it's nice if the environment is in sync with the usual shell.

It also `set filetype=bash` for .envrc files.

Features
--------

* direnv environment loading
* filetype=bash for .envrc files

Limitations
-----------

The vimscript syntax seems to limit keys to alphanumeric characters. If any
environment variable key is something different the plugin might fail.

Ideally direnv would only execute when changing directory but vim doesn't seem
to have a callback for that. So instead we settle to using the VimEnter and
BufEnter autocmd.

Install
-------

direnv support is still fresh so you'll need a version from the master branch.

Then install the plugin.
With [Pathogen](https://github.com/tpope/vim-pathogen)

```
git clone https://github.com/zimbatm/direnv.vim.git ~/.vim/bundle/direnv.vim
```

and restart.

Make sure to install the latest version 

TODO
----

Work out the quirks.

I would love to only execute direnv whenever the directory changes but vim
doesn't seem to have the related autocmd event. The 'NERD tree" plugin has the
same issue.

Allow/deny authorization mechanism.

.envrc edit integration

Add proper vim documentation.

My vimscript skill is tangent to zero, feedback is welcome
<https://github.com/zimbatm/direnv.vim>

