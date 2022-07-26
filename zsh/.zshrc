# --------------------------------------------------------------------------------------- Initialization

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# --------------------------------------------------------------------------------------- Oh my zsh

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster" # Set oh-my-zsh theme

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

# --------------------------------------------------------------------------------------- Develop

# golang related
export GOROOT=/usr/local/go
export GOPATH=~/.config/go

# export $PATH
export PATH=$PATH:$HOME/.local/bin:$GOROOT/bin:$GOPATH:$GOPATH/bin

# --------------------------------------------------------------------------------------- Miscellaneous

export EDITOR="nvim"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
