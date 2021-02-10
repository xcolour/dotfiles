Install dotfiles with the deploy script:

    $ sh deploy.sh

Tries to follow the [XDG base directory
spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
as much as possible.

The script does the following:

 * Clear out `$PWD/dotfiles-backup/`.
 * Symlink everything under `config` into `$XDG_CONFIG_HOME`. Moves everything
   that already exists to `$PWD/dotfiles-backup/` first.
 * Symlink everything under `home` into `$HOME`. Again back up existing files to
   `$PWD/dotfiles-backup`.
 * Clone Vundle into `~/.vim/bundle/vundle/` and run `BundleInstall`.
 * Copy files under `local` into the appropriate locations only if they don't
   already exist. These are for handling local configuration that shouldn't or
   can't be version controlled.
