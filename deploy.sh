#!/bin/bash

set -euo pipefail

mkdir -p dotfiles-backup

# XDG layout
xcache="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdata="${XDG_DATA_HOME:-${HOME}/.local/share}"
xconfig="${XDG_CONFIG_HOME:-${HOME}/.config}"

userbin="$HOME/.local/bin"

mkdir -p "$xcache" "$xdata" "$xconfig" "$userbin"

function link {
    src="$1"
    dest="$2"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "../dotfiles-backup/."
    fi
    if [ ! -e "$dest" ]; then
        ln -sf "$src" "$dest"
    fi
}

# deploy to XDG dirs
mkdir -p "${xcache}/zsh"
mkdir -p "${xdata}/zsh"
cd config
for d in *
do
    link "$(pwd)/$d" "${xconfig}/$d"
done
cd ..

# deploy to home
cd home
for f in *
do
    link "$(pwd)/${f}" "$HOME/.${f}"
done
cd ..

# deploy to user binaries
mkdir -p "$userbin"
cd bin
for f in *
do
    link "$(pwd)/${f}" "$userbin/${f}"
done
cd ..

# install vim-plug
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    mkdir -p "$HOME/.vim/autoload"
    curl -o "$HOME/.vim/autoload/plug.vim" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

# create local files
if [ ! -e "$HOME/.config/zsh/00-local.zsh" ]; then
    cp local/local.zsh config/zsh/00-local.zsh
fi
if [ ! -e "$HOME/.config/git/config-local" ]; then
    cp local/gitconfig-local config/git/config-local
fi
dconfig="$xconfig/duplicity"
mkdir -p "$dconfig"
if [ ! -e "$dconfig/config" ]; then
    cp local/duplicity-config "$dconfig/config"
fi
if [ ! -e "$dconfig/excludes" ]; then
    cp local/duplicity-excludes "$dconfig/excludes"
fi

# download nerdfonts
new_font=0
function get_font {
    local font_name="$1"
    local font_url="$2"
    shift 2
    local font_dir="$HOME/.local/share/fonts/$font_name"
    mkdir -p "$font_dir"
    if [ ! -d "$font_dir" ] || [ -z "$(ls -A "$font_dir" 2> /dev/null)" ]; then
        curl -o "$font_dir/font.zip" "$font_url"
        unzip "$font_dir/font.zip" "$@" -d "$font_dir"
        rm "$font_dir/font.zip"
        new_font=1
    fi
}
get_font sourcecodepro-nerd \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip \
    "Sauce Code Pro Medium Nerd Font Complete.ttf" \
    "Sauce Code Pro Bold Nerd Font Complete.ttf" \
    "Sauce Code Pro Medium Italic Nerd Font Complete.ttf" \
    "Sauce Code Pro Bold Italic Nerd Font Complete.ttf"
get_font jetbrainsmono-nerd \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip \
    "JetBrains Mono Regular Nerd Font Complete Mono.ttf" \
    "JetBrains Mono Italic Nerd Font Complete Mono.ttf" \
    "JetBrains Mono Bold Nerd Font Complete Mono.ttf" \
    "JetBrains Mono Bold Italic Nerd Font Complete Mono.ttf"
if [ "$new_font" = "1" ]; then
    echo "Hint: Run 'fc-cache -v' to rebuild your font cache"
fi
