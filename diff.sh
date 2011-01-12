#!/bin/bash

diff -U 0 vimrc ~/.vimrc
echo
diff -U 0 gitconfig.template ~/.gitconfig
echo
diff -U 0 gitignore ~/.gitignore
echo
diff -U 0 mostrc ~/.mostrc
echo
diff -U 0 zshrc ~/.zshrc
echo
diff -U 0 oh-my-zsh/svn.zsh ~/.oh-my-zsh/lib/svn.zsh
echo
diff -U 0 oh-my-zsh/xcolour.zsh-theme ~/.oh-my-zsh/themes/xcolour.zsh-theme

echo
diff -r -U 0 vim ~/.vim
