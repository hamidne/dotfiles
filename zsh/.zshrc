# in the name of God

# --------------------------------------------------------------------------------------- Tmux

# tns is a shorthand for tmux-new-session
function tns() {
  session_name=$1

  if [ -z "$session_name" ]; then
    # get basename of the current directory
    session_name=${PWD##*/}
  fi

  # create a new new-session based on current working directory
  if ! tmux has-session -t "$session_name" 2> /dev/null; then
    TMUX='' tmux new-session -s "$session_name" -d
  fi

  # attach if outside of tmux, switch if you're in tmux.
  if [ -z "$TMUX" ]; then
    tmux attach -t "$session_name"
  else
    tmux switch-client -t "$session_name"
  fi
}

# tss is a shorthand for tmux-switch-session
function tss() {
  select select in $(tmux ls -F '#S'); do
    break;
  done

  if [ -z "$select" ]
  then
    echo "You didn't select an appropriate choice"
  else
    tns "$select"
  fi
}

# --------------------------------------------------------------------------------------- Neovim

export EDITOR="nvim"
alias vim="nvim"

# --------------------------------------------------------------------------------------- Oh-my-zsh

export ZSH="$HOME/.oh-my-zsh"

SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true # Show prefix before first line in prompt
ZSH_THEME="spaceship" # Set theme

plugins=(
  git # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
  history-substring-search # ZSH port of Fish history search. Begin typing command, use up arrow to select previous use
  zsh-autosuggestions # Suggests commands based on your history
  zsh-completions # More completions
  zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
  colored-man-pages # Self-explanatory
  docker # docker auto-completions
  kubectl # kubernetes auto-completions
)

autoload -U compinit && compinit # reload completions for zsh-completions

source $ZSH/oh-my-zsh.sh # required

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5' # Colorize autosuggest

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# --------------------------------------------------------------------------------------- Spaceship-prompt

# Spaceship-prompt customization
SPACESHIP_PROMPT_ORDER=(
  dir             # Current directory section
  user            # Username section
  host            # Hostname section
  git             # Git section (git_branch + git_status)
  time            # Time stampts section

  # languages related
  golang rust pyenv

  # devops related
  # docker aws kubecontext
  
  exec_time       # Execution time
  line_sep        # Line break
  battery         # Battery level and status
  vi_mode         # Vi-mode indicator
  jobs            # Background jobs indicator
  char            # Prompt character
)

# PROMPT
SPACESHIP_DIR_PREFIX="%{$fg[blue]%}┌─[%b "
SPACESHIP_DIR_SUFFIX="%{$fg[blue]%} ] "
SPACESHIP_CHAR_SYMBOL="%{$fg[blue]%}└─▪%b "

# GOLANG
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_GOLANG_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_GOLANG_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_GOLANG_SYMBOL="🐹 "
SPACESHIP_GOLANG_COLOR="cyan"

# RUST
SPACESHIP_RUST_SHOW=true
SPACESHIP_RUST_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_RUST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_RUST_SYMBOL="𝗥 "
SPACESHIP_RUST_COLOR="red"

# PYENV
SPACESHIP_PYENV_SHOW=true
SPACESHIP_PYENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_PYENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_PYENV_SYMBOL="🐍 "
SPACESHIP_PYENV_COLOR="yellow"

# --------------------------------------------------------------------------------------- Develop

# ssh related
alias sshkey="xclip -selection clipboard < ~/.ssh/id_ed25519.pub && echo 'SSH Public Key copied to clipboard'"

# vpn related
alias snappvpnup="nmcli con up id snapp"
alias snappvpndown="nmcli con down id snapp"

# golang related
export GOROOT=/usr/local/go
export GOPATH=~/.config/go

# export $PATH
export PATH=$PATH:$HOME/.local/bin:$GOROOT/bin:$GOPATH:$GOPATH/bin

# --------------------------------------------------------------------------------------- Miscellaneous

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
