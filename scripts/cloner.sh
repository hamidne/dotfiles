#!/bin/bash
set -e

dotfiles_home=~/.dotfiles

# make git be quiet
quiet_git() {
	stdout=$(mktemp)
	stderr=$(mktemp)

	if ! git "$@" </dev/null >"$stdout" 2>"$stderr"; then
		cat "$stderr" >&2
		rm -f "$stdout" "$stderr"
		exit 1
	fi

	rm -f "$stdout" "$stderr"
}

# -------------------------------------------------------------------------- dotfiles

echo "Cloning dotfiles ..."
quiet_git clone "https://github.com/mohammadne/.dotfiles.git" "$dotfiles_home"

# --------------------------------------------------------------------------  ZSH

echo "Installing ZSH plugins ..."
quiet_git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
quiet_git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
quiet_git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
quiet_git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"

# -------------------------------------------------------------------------- Tmux

echo "Installing Tmux package manager ..."
quiet_git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# -------------------------------------------------------------------------- NeoVIM

echo "Installing & Activating Neovim plugin manager ..."
curl -sfLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qa || echo "Something went wrong installing Neovim plugins."

# -------------------------------------------------------------------------- Fonts

echo "Installing necessary fonts ..."
quiet_git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && cd .. && rm -rf fonts

