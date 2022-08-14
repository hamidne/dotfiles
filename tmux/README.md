# TMUX

## install [tmux](https://github.com/tmux/tmux/wiki/Installing)

``` bash
sudo dnf install -y tmux
```

## install [tmux plugin manager](https://github.com/tmux-plugins/tpm)

``` bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## how to add a theme config

``` conf
background="" # background color
foreground="" # foreground color over background

edge_bg="" # edges background color
edge_fg="" # foreground color over edge_bg

hover_bg="" # hoverd & selected pane background color
hover_fg="" # foreground color over hover_bg

inactive="" # main inactive color
active="" # active color
```

## copy config files

- `.tmux.conf` --> `~/`

- `themes` --> `~/.tmux`
