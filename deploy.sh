#!/bin/bash

set -e

# clean out old backups
rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# XDG layout
xcache="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdata="${XDG_DATA_HOME:-${HOME}/.local/share}"
xconfig="${XDG_CONFIG_HOME:-${HOME}/.config}"

# deploy to XDG dirs
mkdir -p "${xcache}/zsh"
mkdir -p "${xdata}/zsh"
cd config
for d in *
do
    dest="${xconfig}/$d"
    if [ -e "$dest" ]; then
        mv "$dest" "../dotfiles-backup/$d"
    fi
    ln -sf "$(pwd)/$d" "$dest"
done
cd ..

# deploy to home
cd home
for f in *
do
    if [ -e ~/.${f} ]; then
        mv ~/.${f} ../dotfiles-backup/${f}
    fi
    ln -sf "$(pwd)/${f}" ~/.${f}
done
cd ..

# install vundle for vim
if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    cd ~/.vim/bundle/vundle
    git pull
    cd -
fi
vim +BundleInstall +qall
vim +BundleClean +qall

# create local files
if [ ! -e config/zsh/00-local.zsh ]; then
    cp local/local.zsh config/zsh/00-local.zsh
fi
if [ ! -e config/git/config-local ]; then
    cp local/gitconfig-local config/git/config-local
fi
