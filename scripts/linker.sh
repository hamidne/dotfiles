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

echo 'test'