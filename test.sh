#!/bin/bash

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

dotfiles_dir="$HOME/.dotfiles"                                         # dotfiles directory
dotfiles_repo="https://github.com/aaronkjones/noobs-term-dotfiles.git" # dotfiles repo

quiet_git clone "$dotfiles_repo" "$dotfiles_dir"