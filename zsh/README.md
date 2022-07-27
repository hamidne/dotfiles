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
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

- Terminal multiplexing

- Window tabbing

- Nord theming

- Persistence
