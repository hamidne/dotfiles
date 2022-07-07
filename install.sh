#!/bin/bash
set -e

# Set foreground colors
number_of_colors=$(tput colors)
if [ -t 1 ] && [ -n "$number_of_colors" ] && [ "$number_of_colors" -ge 8 ]; then
	read -r BLUE PURPLE NORMAL <<< "$(tput setaf 4) $(tput setaf 5) $(tput sgr0)"
fi

dotfiles_dir="$HOME/.dotfiles"                             # dotfiles directory
dotfiles_repo="https://github.com/mohammadne/dotfiles.git" # dotfiles repo
nvim_config="$HOME/.config/nvim/init.vim"                  # neovim config location
platform="unknown"                                         # default to unknown platform

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

# install dotfiles
install_dotfiles() {
	echo "Installing dotfiles into $dotfiles_dir..."
	quiet_git clone "$dotfiles_repo" "$dotfiles_dir"
	echo "Symbollically linking dotfiles to home directory (e.g. ln -s $dotfiles_dir/.zshrc $HOME/.zshrc)"
	find "$dotfiles_dir" -type f -name ".*" -exec ln -sf {} "$HOME" \; >/dev/null 2>&1
	if [ ! -d "$HOME/.config/nvim" ]; then
		mkdir -p "$HOME/.config/nvim"
	fi
	ln -s "$dotfiles_dir/init.vim" "$nvim_config"
}

# backup and remove dotfiles
if [ -d "$dotfiles_dir" ]; then
	echo "Old dotfiles exist"
	exit 0
fi

# find current platform and distribution
if [ "$(uname)" = 'Linux' ]; then
	platform='Linux'
	if type lsb_release >/dev/null 2>&1; then
		distro="$(lsb_release -si)"
	elif [ -f "/etc/fedora-release" ]; then
		distro='Fedora'
	elif [ -f "/etc/arch-release" ]; then
		distro='Arch'
	else
		echo "unsupported distribution!"
		exit 0
	fi
elif [ "$(uname)" = 'Darwin' ]; then
	platform='Mac'
else
	echo "unsupported platform!"
	exit 0
fi

echo -e "$platform platform with $distro distribution\n"

dependencies="
git \
curl \
wget \
chsh \
zsh \
tmux \
neovim \
python3-neovim \
"

echo "Installing dependencies ..."
if [ "$platform" = 'Linux' ]; then
	if [ "$distro" = 'Ubuntu' ] || [ "$distro" = 'Debian' ]; then
		sudo apt-get -qq update
		for dependency in $dependencies; do
			sudo apt-get -qq install -y "$dependency"
		done
	elif [ "$distro" = 'Arch' ]; then
		for dependency in $dependencies; do
			sudo pacman -q -S --noconfirm "$dependency" 1>/dev/null
		done
	elif [ "$distro" = 'Fedora' ]; then
		for dependency in $dependencies; do
			sudo dnf -y -q install "$dependency"
		done
	fi
elif [ $platform = 'Mac' ]; then
	if ! type "$(which brew)"; then
		echo "Brew not installed. Installing ..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "Brew already installed. Proceeding ..."
		echo
	fi
	echo "Installing dependencies with Brew"
	echo
	for d in $dependencies; do
		brew info "$d" | grep --quiet 'Not installed' && brew install "$d"
	done
fi
echo -e "Done\n"

# -------------------------------------------------------------------------- Oh My Zsh

echo "Installing Oh My Zsh ..."
quiet_git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
if [ $platform = 'Linux' ]; then
	sudo chsh -s "$(which zsh)" "$(whoami)"
elif [ $platform = 'Mac' ]; then
	sudo dscl . -create /Users/$USER UserShell "$(which zsh)"
fi
echo -e "Done\n"


# install dotfiles
install_dotfiles
echo

#  zsh plugins
echo "Installing Zsh plugins..."
quiet_git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
quiet_git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
quiet_git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
quiet_git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
echo "Done"
echo
# tmux package manager
echo "Installing Tmux package manager into $HOME/.tmux..."
quiet_git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
echo "Done"
echo
# vim-plug plugin manager
echo "Installing Vim-plug plugin manager into $HOME/.local/share/nvim/site/autoload/plug.vim..."
curl -sfLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Done"
echo
# activate nvim plugins
echo "Activating Neovim plugins..."
mkdir -p "$HOME/.config/nvim"
nvim +PlugInstall +qa || echo "Something went wrong installing Neovim plugins. Check init.vim for errors and try again."
echo "Done"
echo
# install spaceship-prompt theme for zsh
echo "Installing Spaceship-prompt theme for Zsh..."
quiet_git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"
ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"
echo "Done"
echo
# install nord theme for gnome terminal
if [ "$platform" = 'Linux' ]; then
	# check if running desktop or headless
	if xhost >/dev/null 2>&1; then
		echo "Installing Nord theme for Gnome Terminal..."
		curl -sO https://raw.githubusercontent.com/arcticicestudio/nord-gnome-terminal/develop/src/nord.sh && chmod +x nord.sh && ./nord.sh
		rm -f nord.sh
		echo "Done"
	fi
elif [ "$platform" = 'Mac' ]; then
	echo "Downloading Nord theme for iTerm"
	temp_dir=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')
	wget -q -O "$temp_dir/Nord.itermcolors" https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/master/src/xml/Nord.itermcolors
	echo "Done"
fi


echo
echo "Installing Powerline fonts..."

quiet_git clone https://github.com/powerline/fonts.git --depth=1 &&
	cd fonts &&
	./install.sh &&
	cd .. &&
	rm -rf fonts
echo "Done"
echo
if [ "$platform" = 'Mac' ] && [ "${TERM_PROGRAM}" = "iTerm.app" ]; then
	echo 'Installing Nord theme for iTerm...'
	open "$temp_dir/Nord.itermcolors"
fi
echo
echo '****************************************************************************************************'
echo '    _            __        ____      __  _                                           __     __     '
echo '   (_)___  _____/ /_____ _/ / /___ _/ /_(_)___  ____     _________  ____ ___  ____  / /__  / /____ '
echo "  / / __ \/ ___/ __/ __ \`/ / / __ \`/ __/ / __ \/ __ \   / ___/ __ \/ __ \`__ \/ __ \/ / _ \/ __/ _ "
echo ' / / / / (__  ) /_/ /_/ / / / /_/ / /_/ / /_/ / / / /  / /__/ /_/ / / / / / / /_/ / /  __/ /_/  __/'
echo '/_/_/ /_/____/\__/\__,_/_/_/\__,_/\__/_/\____/_/ /_/   \___/\____/_/ /_/ /_/ .___/_/\___/\__/\___/ '
echo '                                                                          /_/                      '
echo '***************************************************************************************************'
echo ''
echo "      * Note: You will have to log out and back in for Zsh to be set as the default shell."
echo "              If you don't want to log out now, enter 'zsh'"
echo ''
echo ''
echo '      * Press Ctrl + a, then I to load Tmux plugins'
echo ''
if [ "$platform" = 'Linux' ]; then
	echo '      * In Gnome Terminal preferences, set Nord as your default profile'
elif [ "$platform" = 'Mac' ]; then
	echo '      * In iTerm, set your color profile to Nord'
fi
echo ''
echo '      * Set an appropriate font (e.g. Inconsolata for Powerline)'
echo ''
echo ''
