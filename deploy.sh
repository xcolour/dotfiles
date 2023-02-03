#!/bin/bash

set -eo pipefail

if command -v unzip > /dev/null; then
    UNZIPCMD="unzip"
fi
if command -v vim > /dev/null; then
    VIMCMD="vim"
fi
if command -v wget > /dev/null; then
    DLCMD="wget -O"
elif command -v curl > /dev/null; then
    DLCMD="curl -Lo"
fi
if [ -z "$UNZIPCMD" ] || [ -z "$VIMCMD" ] || [ -z "$DLCMD" ]; then
    echo "requires 'unzip', 'vim', and either 'wget' or 'curl'"
    exit 1
fi

set -u

# XDG layout
xcache="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdata="${XDG_DATA_HOME:-${HOME}/.local/share}"
xconfig="${XDG_CONFIG_HOME:-${HOME}/.config}"

userbin="$HOME/.local/bin"
systemd="$xconfig/systemd/user"

uname=$(uname | tr '[:upper:]' '[:lower:]')

mkdir -p "$xcache" "$xdata" "$xconfig" "$userbin" "$systemd"

function link {
    link_src="$1"
    link_dest="$2"
    if [ -e "$link_dest" ] && [ ! -L "$link_dest" ]; then
        mkdir -p "../dotfiles-backup"
        mv "$link_dest" "../dotfiles-backup/."
    fi
    if [ ! -e "$link_dest" ]; then
        ln -sf "$link_src" "$link_dest"
    fi
}

function deploy {
  deploy_src="$1"
  deploy_dest="$2"
  if [ -e "$deploy_src/all" ]; then
    cd "$deploy_src/all"
    for f in *
    do
        link "$(pwd)/${f}" "$deploy_dest/${f}"
    done
    cd ../..
  fi
  if [ -e "$deploy_src/$uname" ]; then
    cd "$deploy_src/$uname"
    for f in *
    do
        link "$(pwd)/${f}" "$deploy_dest/${f}"
    done
    cd ../..
  fi
}

# deploy to home
cd home
for f in *
do
    link "$(pwd)/${f}" "$HOME/.${f}"
done
cd ..

# deploy to XDG dirs
mkdir -p "${xcache}/zsh"
mkdir -p "${xdata}/zsh"
deploy config "$xconfig"

# deploy user executables
deploy bin "$userbin"

# deploy systemd user units
deploy systemd "$systemd"

autoload="$HOME/.vim/autoload"
mkdir -p "$autoload"
# install vim-plug
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    $DLCMD "$HOME/.vim/autoload/plug.vim" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $VIMCMD +PlugInstall +qall
fi

# deploy custom scripts to vim autoload
cd vim
for f in *
do
    link "$(pwd)/$f" "$autoload/$f"
done
cd ..

# create local files
if [ ! -e "$HOME/.config/zsh/00-local.zsh" ]; then
    cp local/local.zsh config/zsh/00-local.zsh
fi
if [ ! -e "$HOME/.config/git/config-local" ]; then
    cp local/gitconfig-local config/git/config-local
fi
if [ ! -e "$HOME/.config/kitty/local.conf" ]; then
    cp local/kitty-local.conf config/kitty/local.conf
fi
if [ "$uname" = "linux" ]; then
  dconfig="$xconfig/duplicity"
  mkdir -p "$dconfig"
  if [ ! -e "$dconfig/config" ]; then
      cp local/duplicity-config "$dconfig/config"
  fi
  if [ ! -e "$dconfig/excludes" ]; then
      cp local/duplicity-excludes "$dconfig/excludes"
  fi
fi

# download nerdfonts
if command -v fc-cache > /dev/null; then
    new_font=0
    function get_font {
        local font_name="$1"
        local font_url="$2"
        shift 2
        local font_dir="$HOME/.local/share/fonts/$font_name"
        mkdir -p "$font_dir"
        if [ ! -d "$font_dir" ] || [ -z "$(ls -A "$font_dir" 2> /dev/null)" ]; then
            $DLCMD "$font_dir/font.zip" "$font_url"
            $UNZIPCMD "$font_dir/font.zip" "$@" -d "$font_dir"
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
    "JetBrains Mono Bold Italic Nerd Font Complete Mono.ttf" \
    "JetBrains Mono Regular Nerd Font Complete.ttf" \
    "JetBrains Mono Italic Nerd Font Complete.ttf" \
    "JetBrains Mono Bold Nerd Font Complete.ttf" \
    "JetBrains Mono Bold Italic Nerd Font Complete.ttf"
    if [ "$new_font" = "1" ]; then
        echo "Hint: Run 'fc-cache -v' to rebuild your font cache"
    fi
fi

# download sway wallpaper
if command -v sway > /dev/null; then
  bg_dir="$xdata/backgrounds"
  if [ ! -d "$bg_dir" ] || [ -z "$(ls -A "$bg_dir" 2> /dev/null)" ]; then
    mkdir -p "$bg_dir"
  fi
  if [ ! -e "$bg_dir/sway.png" ]; then
    $DLCMD "$bg_dir/sway.png" "https://raw.githubusercontent.com/swaywm/sway/master/assets/Sway_Wallpaper_Blue_1366x768.png"
  fi
  if [ ! -e "$bg_dir/default" ]; then
    ln -s "$bg_dir/sway.png" "$bg_dir/default"
  fi
fi
