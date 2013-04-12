#!/bin/sh

if [ -d $HOME/.dotfiles ]
then
    echo "Directory $HOME/.dotfiles already exists, refusing to bootstrap!"
    exit 1
fi

alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

mkdir $HOME/.dotfiles.git
dotfiles init

dotfiles remote add origin git@github.com:dholm/dotfiles.git
dotfiles config branch.master.remote origin
dotfiles config branch.master.merge refs/heads/master
dotfiles fetch

dotfiles merge origin/master
dotfiles submodule init
dotfiles submodule update
dotfiles submodule foreach git checkout master

dotfiles submodule foreach git submodule init
dotfiles submodule foreach git submodule update
dotfiles submodule foreach git submodule foreach git checkout master
