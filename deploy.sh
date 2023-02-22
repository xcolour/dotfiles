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

uname=$(uname | tr '[:upper:]' '[:lower:]')

# XDG layout
xcache="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdata="${XDG_DATA_HOME:-${HOME}/.local/share}"
xconfig="${XDG_CONFIG_HOME:-${HOME}/.config}"

userbin="$HOME/.local/bin"
systemd="$xconfig/systemd/user"

mkdir -p "$xcache" "$xdata" "$xconfig" "$userbin"
mkdir -p "${xcache}/zsh"
mkdir -p "${xdata}/zsh"
if [ "linux" = "$uname" ]; then
  mkdir -p "$systemd"
fi

function link {
    link_src="$1"
    link_dest="$2"
    if [ -e "$link_dest" ] && [ ! -L "$link_dest" ]; then
        mkdir -p "../dotfiles-backup"
        mv "$link_dest" "../dotfiles-backup/."
    fi
    ln -snf "$link_src" "$link_dest"
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
    cp local/local.zsh "$HOME/.config/zsh/00-local.zsh"
fi
if [ ! -e "$HOME/.config/git/config-local" ]; then
    cp local/gitconfig-local "$HOME/.config/git/config-local"
fi
if [ "$uname" = "linux" ]; then
  if [ ! -e "$HOME/.config/kitty/local.conf" ]; then
      cp local/kitty-local.conf "$HOME/.config/kitty/local.conf"
  fi
  dconfig="$xconfig/duplicity"
  mkdir -p "$dconfig"
  if [ ! -e "$dconfig/config" ]; then
      cp local/duplicity-config "$dconfig/config"
  fi
  if [ ! -e "$dconfig/excludes" ]; then
      cp local/duplicity-excludes "$dconfig/excludes"
  fi
fi

# download custom fonts
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
