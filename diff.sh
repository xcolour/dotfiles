#!/bin/bash

diff -U 0 vimrc ~/.vimrc
echo
diff -U 0 gitconfig.template ~/.gitconfig
echo
diff -U 0 gitignore ~/.gitignore
echo
diff -U 0 zshrc ~/.zshrc
echo
diff -U 0 zsh ~/.zsh

echo
diff -r -U 0 -x "tags" -x ".netrwhist" vim ~/.vim
