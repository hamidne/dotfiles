#!/bin/bash
set -e

# exit on non-linux platforms.
if [ "$(uname)" != 'Linux' ]; then
	echo "unsupported platform!"
	exit 0
fi

read -p "Backup old dotfiles if exists? ([y]es / [n]o)" backup_dotfiles

function quiet_git() {
	stdout=$(mktemp)
	stderr=$(mktemp)

	if ! git "$@" </dev/null >"$stdout" 2>"$stderr"; then
		cat "$stderr" >&2
		rm -f "$stdout" "$stderr"
		exit 1
	fi

	rm -f "$stdout" "$stderr"
}

# type($1) - path($2)
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

# -------------------------------------------------------------------------- install dependencies

# get linux distribution
distro=$(grep '^ID=' /etc/os-release | awk -F  "=" '{print $2}')

dependencies="
git \
curl \
wget \
zsh \
tmux \
neovim \
python3-neovim \
"

echo "Installing dependencies ..."
if [ "$distro" = 'ubuntu' ] || [ "$distro" = 'debian' ]; then
	sudo apt-get -qq update
	for dependency in $dependencies; do
		sudo apt-get -qq install -y "$dependency"
	done
elif [ "$distro" = 'fedora' ]; then
	for dependency in $dependencies; do
		sudo dnf -y -q install "$dependency"
	done
elif [ "$distro" = 'arch' ]; then
	for dependency in $dependencies; do
		sudo pacman -q -S --noconfirm "$dependency" 1>/dev/null
	done
fi
echo -e "Done\n"

# -------------------------------------------------------------------------- Oh My Zsh

backup "d" ~/.oh-my-zsh
echo "Installing Oh My Zsh ..."
quiet_git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
sudo usermod --shell "$(which zsh)" "$(whoami)"
echo -e "Done\n"

# -------------------------------------------------------------------------- dotfiles

echo "Installing dotfiles"
dotfiles_dir="tmp/dotfiles"
quiet_git clone "https://github.com/mohammadne/dotfiles.git" "$dotfiles_dir"

backup "f" ~/.zshrc
mv "$dotfiles_dir/configs/.zshrc" ~

backup "f" ~/.tmux.conf
mv "$dotfiles_dir/configs/.tmux.conf" ~

mkdir -p ~/.config/nvim
backup "f" ~/.config/nvim/init.vim
mv "$dotfiles_dir/configs/init.vim" ~/.config/nvim

rm -rf "$dotfiles_dir"
echo -e "Done\n"

# --------------------------------------------------------------------------  zsh plugins

echo "Installing Zsh plugins ..."
quiet_git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
quiet_git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
quiet_git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
quiet_git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
echo -e "Done\n"

# -------------------------------------------------------------------------- tmux package manager

backup "f" ~/.config/nvim/init.vim
echo "Installing Tmux package manager ..."
quiet_git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo -e "Done\n"

# -------------------------------------------------------------------------- vim-plug plugin manager

echo "Installing Vim-plug plugin manager ..."
curl -sfLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo -e "Done\n"

# -------------------------------------------------------------------------- activate nvim plugins

echo "Activating Neovim plugins ..."
nvim +PlugInstall +qa || echo "Something went wrong installing Neovim plugins. Check init.vim for errors and try again."
echo -e "Done\n"

# -------------------------------------------------------------------------- install powerline fonts

echo "Installing Powerline fonts ..."
quiet_git clone https://github.com/powerline/fonts.git --depth=1 &&
	cd fonts && ./install.sh && cd .. && rm -rf fonts
echo -e "Done\n"

# -------------------------------------------------------------------------- install spaceship-prompt theme for zsh

echo "Installing Spaceship-prompt theme for Zsh ..."
quiet_git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"
ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"
echo -e "Done\n"

# -------------------------------------------------------------------------- install nord theme for gnome terminal

if xhost >/dev/null 2>&1; then # check if running desktop or headless
	echo "Installing Nord theme for Gnome Terminal..."
	curl -sO https://raw.githubusercontent.com/arcticicestudio/nord-gnome-terminal/develop/src/nord.sh && chmod +x nord.sh && ./nord.sh
	rm -f nord.sh
	echo -e "Done\n"
fi

# -------------------------------------------------------------------------- installation complete

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
echo '      * In Gnome Terminal preferences, set Nord as your default profile'
echo ''
