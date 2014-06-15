direnv.vim - yup
================

STATUS: Experimental

Adds support for direnv environment loading inside of vim. For now it's more
like a proof of concept.

On VimEnter and BufEnter, vim evaluates the `direnv export vim` output which
updates the environment variables to the current directory. Any other shell
command can take advantage of that.

Features
--------

* direnv environment loading
* filetype=bash for .envrc files

Install
-------

Install direnv from the `feature/vim-support` branch.

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

Better integration with vim ; allow/deny authorization mechanism, direnv edit

Add proper vim documentation.

My vimscript skill is tangent to zero so feedback is welcome
<https://github.com/zimbatm/direnv.vim>



