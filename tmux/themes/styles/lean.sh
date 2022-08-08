#!/bin/bash

# load color palette config
source ~/.tmux/themes/configs/"$1".conf

function set() {
   tmux set-option -gq "$1" "$2"
}

function setw() {
   tmux set-window-option -gq "$1" "$2"
}

# active left status style
set "status-left" "\
#[fg=$edge_fg,bg=$edge_bg,bold] #S \
#[fg=$foreground,bg=$background] │ "

# prefix highlight when pressed
set "@prefix_highlight_fg" "$foreground"
set "@prefix_highlight_bg" "$background"
set "@prefix_highlight_prefix_prompt" "prefix"
set "@prefix_highlight_empty_prompt" ""
set "@prefix_highlight_output_prefix" ""
set "@prefix_highlight_output_suffix" " "

# active right status style
set "status-right" "\
#{prefix_highlight}\
#[fg=$hover_fg,bg=$hover_bg,nounderscore,noitalics] %H:%M %a \
#[fg=$edge_fg,bg=$edge_bg,bold] #{USER}@#h "

# inactive status windows style
set "window-status-format" "\
#[fg=$foreground,bg=$background] #F#I:#W "

# active status windows style
set "window-status-current-format" "\
#[fg=$hover_fg,bg=$hover_bg,nobold] #I:#W "
