#!/bin/bash

set -e

rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# deploy
for f in vimrc gvimrc gitconfig gitignore zshrc zsh vim
do
    if [ -e ~/.${f} ]; then
        mv ~/.${f} dotfiles-backup/${f}
    fi
    ln -s `pwd`/${f} ~/.${f}
done
