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

