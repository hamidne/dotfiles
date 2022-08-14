# ZSH

## install zsh

``` bash
# install dependencies
sudo dnf install -y zsh curl wget

# change default shell
sudo usermod --shell "$(which zsh)" "$(whoami)"
```

## install [oh-my-zsh](https://ohmyz.sh/#install)

``` bash
# install via curl
ZSH=~/.config/oh-my-zsh sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## install zsh-users custom plugins

``` bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
```

## copy config files

- `p10k` --> `~/.config`

- `.zshrc` --> `~/`

- `.aliases.zsh` --> `~/`

## Features

- Completions

- Auto-suggestions

- Command validation

- Directory history

- Git feedback

- Persistence
