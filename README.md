You're going to want to make changes, so before you do anything, fork this repo
and make it your own.

Clone it somewhere on your local machine:

    $ git clone git://github.com/xcolour/dotfiles.git ~/.dotfiles

I use Pathogen with git sumbodules to manage vim plugins, so clone the plugins
too (if you care about vim):

    $ cd ~/.dotfiles
    $ git submodule update --init

This next step is supposed to back up your existing dotfiles before replacing
them, but since you're smart and I'm just some random guy on the internet,
you'll back up anything you care about by hand first and you won't blame me if
anything goes wrong. Once that's done, you're ready to install your dotfiles:

    $ sh deploy.sh

This script will back up any existing dotfiles to `$REPODIR/dotfiles-backup/`
and then replace the dotfiles in question with symlinks into the repo. It will
also create a file called `.zshrc-local` (if one doesn't already exist) where
you can set up any custom local behavior. Take a look inside the file for ideas.
