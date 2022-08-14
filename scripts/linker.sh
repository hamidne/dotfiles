#!/bin/bash
set -e

dotfiles_home=~/.dotfiles

# check existance of dotfiles directory
if [ ! -d "$dotfiles_home" ]; then
    read -n1 -ep "dotfile directory doesn't exist, clone? ([y]es / [n]o) " confirmation

    # exit the script if not confirmed
    if [[ $confirmation != "y" && $confirmation != "Y" ]]; then
        echo "missing $dotfiles_home, please clone the repository there"
        exit 1
    fi

    git clone https://github.com/mohammadne/dotfiles.git $dotfiles_home --quiet
fi

# source common file to include common stuffs!
source "$dotfiles_home/scripts/common.sh"

# create ~/.config directory which holds most of configurations.
mkdir -p ~/.config

# git
backup "file" ~/.gitconfig
ln -s "$dotfiles_home/git/gitconfig" ~/.gitconfig

# ssh
backup "file" ~/.ssh/config
ln -s "$dotfiles_home/ssh/config" ~/.ssh/config

# zshrc
backup "file" ~/.zshrc
ln -s "$dotfiles_home/zsh/zshrc" ~/.zshrc

# zsh p10k
backup "file" ~/.config/p10k.zsh
ln -s "$dotfiles_home/zsh/p10k.zsh" ~/.config/p10k.zsh

# tmux
backup "directory" ~/.config/tmux
ln -s "$dotfiles_home/tmux" ~/.config/tmux

# vim
backup "directory" ~/.config/vim
ln -s "$dotfiles_home/vim" ~/.config/vim

# nvim
backup "directory" ~/.config/nvim
ln -s "$dotfiles_home/nvim" ~/.config/nvim
