direnv.vim - yup
================

This plugin aim is to integrate [Direnv][direnv] and (Neo)Vim. Because Vim can
shell out to other tools it's nice if the environment is in sync with the usual
shell.

See detail in the [doc][].

Install
-------

Clone the repository to load by [packages][].

```sh
git clone https://github.com/direnv/direnv.vim \
  ~/.vim/pack/foo/start/direnv.vim
```

Or use your favorite plugin manager.

TODO
----

- Allow/deny authorization mechanism.

[direnv]: https://direnv.net
[packages]: https://vimhelp.org/repeat.txt.html#packages
[doc]: https://github.com/direnv/direnv.vim/blob/master/doc/direnv.txt
