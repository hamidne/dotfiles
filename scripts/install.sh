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

dotfiles_home=~/.dotfiles

# source common file to include common stuffs!
source "$dotfiles_home/scripts/common.sh"

# --------------------------------------------------------------------------  dependencies

dependencies="
git \
curl \
wget \
zsh \
tmux \
tmuxp \
vim \
neovim \
"

echo "Installing dependencies ..."

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
        for dependency in $dependencies; do sudo apt-get -qq install -y "$dependency"; done
    elif [ "$distro" = 'fedora' ]; then
		dependencies+=("python3-neovim") # python3-neovim is needed for neovim in redhat distros
        for dependency in $dependencies; do sudo dnf -y -q install "$dependency"; done
    elif [ "$distro" = 'arch' ]; then
        for dependency in $dependencies; do sudo pacman -q -S --noconfirm "$dependency" 1>/dev/null; done
    fi
fi

# --------------------------------------------------------------------------  ZSH

# change default shell if ZSH is not the default running shell
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "changing default shell to ZSH ..."
    if [ $platform = 'Mac' ]; then
        sudo dscl . -create /Users/$USER UserShell "$(which zsh)"
    elif [ $platform = 'Linux' ]; then
        sudo usermod --shell "$(which zsh)" "$(whoami)"
    fi
fi

# create ~/.config directory which holds most of configurations.
mkdir -p ~/.config

echo "Installing Oh My Zsh ..."
backup "directory" ~/.config/oh-my-zsh
ZSH=~/.config/oh-my-zsh sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 1>/dev/null

echo "Installing Oh My Zsh plugins ..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/themes/powerlevel10k --quiet
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions" --quiet
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" --quiet
git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-history-substring-search" --quiet
git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.config/oh-my-zsh/custom}/plugins/zsh-completions" --quiet

# -------------------------------------------------------------------------- Tmux

echo "Installing Tmux package manager ..."
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm --quiet

# -------------------------------------------------------------------------- VIM

echo "Installing & Activating vim-plug ..."
curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qa || echo "Something went wrong installing vim plugins."

# -------------------------------------------------------------------------- NeoVIM

echo "Installing & Activating packer ..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim --quiet
nvim +PackerSync +qa || echo "Something went wrong installing nvim plugins."

# -------------------------------------------------------------------------- Fonts

font_family="FiraCode"
font_weights="Bold SemiBold Medium Retina Regular Light"
font_repository="https://github.com/ryanoasis/nerd-fonts"

font_home=$([ "$platform" == "Mac" ] && echo ~/Library/Fonts || echo ~/.local/share/fonts)
font_home="$font_home/$font_family"

echo "Installing "$font_family" font ..."

for weight in $font_weights; do
    mkdir -p $font_home && cd $font_home
    curl -fLo "$weight.ttf" "$font_repository/raw/master/patched-fonts/$font_family/$weight/complete/Fira%20Code%20$weight%20Nerd%20Font%20Complete.ttf"
done

# Reset font cache on Linux (if fc-cache command exists and manages the fonts)
if [ "$platform" == "Linux" ] && (command -v fc-cache &> /dev/null) ; then
    echo "Resetting font cache ..."
    fc-cache -f "$font_home"
fi

# -------------------------------------------------------------------------- Terminal themes

for theme in "one-dark one-light" ; do
    bash -c "$(curl -so- https://raw.githubusercontent.com/Gogh-Co/Gogh/master/themes/$theme.sh)"
done

# TODO: check to be necessary on ubuntu
# export TERMINAL=gnome-terminal

echo "------------------------------------------------------------------------------------------------------ "
echo "    _            __        ____      __  _                                           __     __         "
echo "   (_)___  _____/ /_____  / / /___ _/ /_(_)___  ____     _________  ____ ___  ____  / /__  / /____     "
echo "  / / __ \/ ___/ __/ __ \`/ / / __ \`/ __/ / __ \/ __ \   / ___/ __ \/ __ \`__ \/ __ \/ / _ \/ __/ _ \ "
echo " / / / / /__  / /_/ /_/ / / / /_/ / /_/ / /_/ / / / /  / /__/ /_/ / / / / / / /_/ / /  __/ /_/  __/    "
echo "/_/_/ /_/____/\__/\____/_/_/\__,_/\__/_/\____/_/ /_/   \___/\____/_/ /_/ /_/ .___/_/\___/\__/\___/     "
echo "                                                                          /_/                          "
echo "------------------------------------------------------------------------------------------------------ "
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