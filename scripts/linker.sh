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

# git
ln -s "$dotfiles_home/git" ~/.git

# zsh related
ln -s "$dotfiles_home/zsh/zshrc" ~/.zshrc
ln -s "$dotfiles_home/zsh/zsh.aliases" ~/.zsh.aliases
ln -s "$dotfiles_home/zsh/p10k.zsh" ~/.config/p10k.zsh

# tmux related
ln -s "$dotfiles_home/tmux/themes" ~/.tmux/themes
ln -s "$dotfiles_home/tmux/tmux.conf" ~/.tmux.conf

# vim
ln -s "$dotfiles_home/vim/vimrc" ~/.vimrc

# nvim
ln -s "$dotfiles_home/nvim" ~/.config/nvim


