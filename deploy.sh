#!/bin/bash

set -e

# template git profile
echo "enter your global git user name:"
read name
echo "enter your global git e-mail:"
read email

sed -e "s|#NAME#|$name|" -e "s|#EMAIL#|$email|" gitconfig.template > gitconfig

# deploy
for f in vimrc gitconfig gitignore zshrc
do
    cp $f ~/.${f}
done

mkdir -p ~/.zsh
cp zsh/* ~/.zsh

mkdir -p ~/.vim
cp -r vim/* ~/.vim

# clean-up
rm gitconfig
