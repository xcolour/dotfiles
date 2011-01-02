#!/bin/bash

set -e

# check for dependencies
echo "Checking for dependencies"
echo " oh-my-zsh..."
if [ ! -e ~/.oh-my-zsh/lib ]; then
    echo "  not found!"
    exit 1
fi
if [ ! -e ~/.oh-my-zsh/themes ]; then
    echo "  not found!"
    exit 1
fi

# template git profile
echo "enter your global git user name:"
read name
echo "enter your global git e-mail:"
read email

sed -e "s|#NAME#|$name|" -e "s|#EMAIL#|$email|" gitconfig.template > gitconfig

# deploy
for f in vimrc gitconfig gitignore mostrc zshrc
do
    cp $f ~/.${f}
done

cp oh-my-zsh/svn.zsh ~/.oh-my-zsh/lib/svn.zsh
cp oh-my-zsh/xcolour.zsh-theme ~/.oh-my-zsh/themes/xcolour.zsh-theme

mkdir -p ~/.vim
cp -r vim/* ~/.vim

# clean-up
rm gitconfig
