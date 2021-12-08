#!/bin/bash

set -euo pipefail

# clean out old backups
rm -rf dotfiles-backup
mkdir -p dotfiles-backup

# XDG layout
xcache="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdata="${XDG_DATA_HOME:-${HOME}/.local/share}"
xconfig="${XDG_CONFIG_HOME:-${HOME}/.config}"

userbin="$HOME/.local/bin"

mkdir -p "$xcache" "$xdata" "$xconfig" "$userbin"

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
    if [ -e "$HOME/.${f}" ]; then
        mv "$HOME/.${f}" "../dotfiles-backup/${f}"
    fi
    ln -sf "$(pwd)/${f}" "$HOME/.${f}"
done
cd ..

# deploy to user binaries
mkdir -p "$userbin"
cd bin
for f in *
do
    if [ -e "$userbin/${f}" ]; then
        mv "$userbin/${f}" "../dotfiles-backup/${f}"
    fi
    ln -sf "$(pwd)/${f}" "$userbin/${f}"
done
cd ..

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# create local files
if [ ! -e ~/.config/zsh/00-local.zsh ]; then
    cp local/local.zsh config/zsh/00-local.zsh
fi
if [ ! -e ~/.config/git/config-local ]; then
    cp local/gitconfig-local config/git/config-local
fi
if [ ! -e ~/.local/share/fonts/sourcecodepro-nerd ]; then
    mkdir -p ~/.local/share/fonts/sourcecodepro-nerd
    unzip local/SourceCodePro.zip \
        "Sauce Code Pro Nerd Font Complete.ttf" \
        "Sauce Code Pro Bold Nerd Font Complete.ttf" \
        "Sauce Code Pro Italic Nerd Font Complete.ttf" \
        "Sauce Code Pro Bold Italic Nerd Font Complete.ttf" \
        -d ~/.local/share/fonts/sourcecodepro-nerd
    echo "Run \'fc-cache -v\' to rebuild your font cache"
fi
dconfig="$xconfig/duplicity"
mkdir -p "$dconfig"
if [ ! -e "$dconfig/config" ]; then
    cp local/duplicity-config "$dconfig/config"
fi
if [ ! -e "$dconfig/excludes" ]; then
    cp local/duplicity-excludes "$dconfig/excludes"
fi
