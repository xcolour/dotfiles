You're going to want to make changes, so before you do anything, fork this repo
and make it your own.

Clone it somewhere on your local machine:

    $ git clone git://github.com/xcolour/dotfiles.git ~/.dotfiles

Then run the deploy script:

    $ sh deploy.sh

This script does the following:
 - Clear out `$PWD/dotfiles-backup/`.
 - Back up any existing dotfiles to `$PWD/dotfiles-backup/`.
 - Replace existing dotfiles with symlinks to the corresponding file in the
   repo.
 - Clone Vundle into `~/.vim/bundle/vundle/` and run `BundleInstall`.
   will back up any existing dotfiles to `$PWD/dotfiles-backup/`
 - Create `~/.zshrc-local` (if one doesn't already exist) for setting up local
   behavior. Take a look inside for ideas.

The prompt will highligh the local host name in red unless `ZSH_LOCAL_ENV=true`
is set. That's a good one for `~/.zshrc-local`.
