#!/bin/bash

set -e

rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# deploy
if [ -z "$XDG_CONFIG_HOME" ];
then
    config_home="$HOME/.config"
else
    config_home="$XDG_CONFIG_HOME"
fi
cd xdg-config
for d in *
do
    dest="$config_home/$d"
    if [ -e "$dest" ]; then
        mv "$dest" ../dotfiles-backup/$d
    fi
    ln -sf "$(pwd)/$d" "$dest"
done
cd ..

for f in vimrc gvimrc gitconfig gitignore zshrc zsh dircolors.conf
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
