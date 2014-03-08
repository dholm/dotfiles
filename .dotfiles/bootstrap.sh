#!/bin/sh

NORMAL="`tput sgr0`"
GREEN="`tput setaf 2; tput bold`"
YELLOW="`tput setaf 3`"
RED="`tput setaf 1`"

if [ -d "$HOME/.dotfiles" ]
then
    echo -e "Directory $HOME/.dotfiles already exists, $REDrefusing to bootstrap!$NORMAL"
    exit 1
fi

alias dotfiles='git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME"'

mkdir "$HOME/.dotfiles.git"
dotfiles init

echo -e " * ${GREEN}Fetching root repository..${NORMAL}"
dotfiles remote add origin https://github.com/dholm/dotfiles.git
dotfiles config branch.master.remote origin
dotfiles config branch.master.merge refs/heads/master
dotfiles fetch

echo -e " * ${GREEN}Fetching each configuration module..${NORMAL}"
dotfiles merge origin/master
dotfiles submodule init
dotfiles submodule update
dotfiles submodule foreach git checkout master

echo -e " * ${GREEN}Fetching any module extensions..${NORMAL}"
dotfiles submodule foreach git submodule init
dotfiles submodule foreach git submodule update
dotfiles submodule foreach git submodule foreach git checkout master

echo -e "${GREEN}Completed successfully.${NORMAL}"
echo -e "If Python is available run the following command to install required packages:"
echo -e "    syspip install -r $HOME/.dotfiles/python-requirements.txt"
