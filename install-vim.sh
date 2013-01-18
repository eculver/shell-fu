#!/usr/bin/env bash

CWD=`pwd`

cd ~/dev/dotfiles
git submodule init
git submodule update

cp -r _vim/* ~/.vim/
cp _vimrc ~/.vimrc

cd $CWD
