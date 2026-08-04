#!/bin/bash

session=$(tmux display-message -p "#{session_name}" 2>/dev/null)
if [ -z "$session" ]; then
    tmux display-message "Error: Not inside a tmux session"
    exit 1
fi

if command -v fd >/dev/null 2>&1; then
    dir_list_cmd="fd . / -t d -d 5 2>/dev/null"
else
    dir_list_cmd="find / -maxdepth 5 -type d 2>/dev/null"
fi

selected=$(eval "$dir_list_cmd" | fzf-tmux -p 60%,40% --prompt="Select working dir: ")

if [ -n "$selected" ]; then
    if TMUX= tmux -C attach -c "$selected" -t "$session" </dev/null >/dev/null 2>&1; then
        tmux display-message "Working dir set to: $selected"
    else
        tmux display-message "Failed to set working dir"
    fi
else
    tmux display-message "Cancelled."
fi
