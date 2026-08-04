#!/bin/bash

declare -A CUSTOM_LAYOUTS=(
	["bottom-term"]="39fe,170x48,0,0[170x38,0,0,10,170x9,0,39,11]"
)

builtin_layouts="even-horizontal
even-vertical
main-horizontal
main-horizontal-mirrored
main-vertical
main-vertical-mirrored
tiled"

all_layouts="$builtin_layouts"
for name in "${!CUSTOM_LAYOUTS[@]}"; do
	all_layouts="$all_layouts"$'\n'"$name"
done

chosen=$(echo "$all_layouts" | fzf-tmux -p 60%,40% --prompt="Select layout: ")

if [ -n "$chosen" ]; then
	if [[ -n "${CUSTOM_LAYOUTS[$chosen]}" ]]; then
		tmux select-layout "${CUSTOM_LAYOUTS[$chosen]}"
	else
		tmux select-layout "$chosen"
	fi
	# tmux display-message "Layout: $chosen"
fi
