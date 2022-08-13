#!/bin/bash
set -e

platform='unknown'
if [ "$(uname)" = 'Darwin' ]; then
	platform="Mac"
elif [ "$(uname)" = 'Linux' ]; then
	platform="Linux"
else
    # exit on non-linux platforms.
	echo "unsupported platform, exiting !"
	exit 0
fi

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

# backup existing files and directories
# parameter 1: type of the backup - string - required
# parameter 2: path to the config file or directory - string - required
function backup() {
	if [ "$1" = "d" ] && [ -d "$2" ]; then
		if [ "$backup_dotfiles" = "${backup_dotfiles#[Yy]}" ]; then
			cp -rf $2 "$2.backup" 2> /dev/null
		fi
		rm -rf $2
	elif [ "$1" = "f" ] && [ -f "$2" ]; then
		if [ "$backup_dotfiles" = "${backup_dotfiles#[Yy]}" ]; then
			cp -f $2 "$2.backup" 2> /dev/null
		fi
		rm -f $2
	fi
}

# --------------------------------------------------------------------------  dependencies

dependencies="
git \
curl \
wget \
zsh \
tmux \
neovim \
"

# install dependencies on MacOS
if [ $platform = 'Mac' ]; then
	if ! type "$(which brew)"; then
		echo "Brew is not installed. Installing ..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

    for d in $dependencies; do
		brew info "$d" | grep --quiet 'Not installed' && brew install "$d"
	done
fi

# install dependencies on Linux
if [ $platform = 'Linux' ]; then
    distro=$(grep '^ID=' /etc/os-release | awk -F  "=" '{print $2}') # get linux distribution

    if [ "$distro" = 'ubuntu' ] || [ "$distro" = 'debian' ]; then
        sudo apt-get -qq update # update package list in debian distors
        for dependency in $dependencies; do sudo apt-get -qq install -y "$dependency" done
    elif [ "$distro" = 'fedora' ]; then
		dependencies+=("python3-neovim") # python3-neovim is needed for neovim in redhat distros
        for dependency in $dependencies; do sudo dnf -y -q install "$dependency" done
    elif [ "$distro" = 'arch' ]; then
        for dependency in $dependencies; do sudo pacman -q -S --noconfirm "$dependency" 1>/dev/null done
    fi
fi

# --------------------------------------------------------------------------  ZSH

echo "Installing ZSH plugins ..."
quiet_git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
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

