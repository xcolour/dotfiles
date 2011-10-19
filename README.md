Check out the repo somewhere and then run `deploy.sh` from inside the repo.

The script will back up any existing dotfiles to `$REPODIR/dotfiles-backup/`
and then replace the dotfiles in question with symlinks into the repo. It will
also create a file called `.zshrc-local` (if one doesn't already exist) where
you can set up an custom local behavior. Take a look inside the file for ideas.

Once you have the symlinks set up, all you have to do to get updates is `git
pull`, the symlinks will take care of the rest!
