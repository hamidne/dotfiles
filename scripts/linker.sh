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

# create ~/.config directory which holds most of configurations.
mkdir -p ~/.config 

# zsh related
ln -s "$dotfiles_home/zsh/zshrc" ~/.zshrc
ln -s "$dotfiles_home/zsh/p10k.zsh" ~/.config/p10k.zsh

# tmux
ln -s "$dotfiles_home/tmux" ~/.config/tmux

# vim
ln -s "$dotfiles_home/vim" ~/.config/vim

# nvim
ln -s "$dotfiles_home/nvim" ~/.config/nvim
