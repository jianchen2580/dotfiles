#!/bin/bash

cd $(dirname "$0")

if [ ! -f ./vimrc ]; then
    git clone https://github.com/lepture/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
fi

link() {
    rm -f "$HOME/.$1"
    ln -s "`pwd`/$1" "$HOME/.$1"
}

link_config() {
    rm -fr "$HOME/.config/$1"
    ln -s "`pwd`/$1" "$HOME/.config/$1"
}

if [ ! -d $HOME/.hide ]; then
    echo "make hide directory"
    mkdir "$HOME/.hide"
fi

if [ ! -d $HOME/.config ]; then
    echo "make config directory"
    mkdir "$HOME/.config"
fi

echo "init vim ...."
if [ ! -d vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git vim/bundle/vundle
fi
link vim
link vimrc
vim +BundleInstall +qall

echo "init git ...."
link gitconfig
link_config gitignore

echo "init hg"
link hgrc
link_config hg-prompt.py

# fish
echo "install fish shell yourself"
link_config fish

echo "init python env ..."
link_config pystartup.py
if which pip > /dev/null; then
    echo "pip already installed"
else
    sudo easy_install pip
fi
if which virtualenv > /dev/null; then
    echo "virtualenv already installed"
else
    sudo pip install virtualenv
    sudo pip install fabric
fi
if [ ! -d $HOME/.venvs ]; then
    echo "create virualenv directory"
    mkdir "$HOME/.venvs"
fi
if [ ! -d $HOME/workspace ]; then
    echo "create workspace"
    mkdir "$HOME/workspace"
fi

