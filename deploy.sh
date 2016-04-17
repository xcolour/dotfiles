#!/bin/bash

set -e

rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# deploy
for f in vimrc gvimrc gitconfig gitignore zshrc zsh dircolors.conf tmux.conf hammerspoon
do
    if [ -e ~/.${f} ]; then
        mv ~/.${f} dotfiles-backup/${f}
    fi
    ln -sf "$(pwd)/${f}" ~/.${f}
done

if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    cd ~/.vim/bundle/vundle
    git pull
    cd -
fi
vim +BundleInstall +qall
vim +BundleClean +qall

if [ ! -e ~/.zshrc-local ]; then
    cp zshrc-local ~/.zshrc-local
fi
