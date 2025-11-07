#!/usr/bin/env bash
set -euo pipefail

# Config
HISTORY_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/huami_args_history"
MAX_HISTORY=50

# Ensure history file exists
mkdir -p "$(dirname "$HISTORY_FILE")"
touch "$HISTORY_FILE"

# Helper: show fuzzel dmenu prompt (allows typing new entries)
fuzzel_input() {
    local prompt="$1"
    # fuzzel --dmenu prints chosen or typed text to stdout
    fuzzel --dmenu --prompt "$prompt" --placeholder "$prompt"
}

# 1) Optional username prompt (uncomment if you want to use it)
# username=$(fuzzel_input "Choose username (or leave empty)")
# if [ -n "$username" ]; then
#     export HUAMI_USER="$username"
# fi

# 2) Prepare history list for argument selection
# Read history (most recent first)
mapfile -t history_lines < <(awk 'NF' "$HISTORY_FILE" | tac)

# Build the menu input: show history entries and allow typing a new argument
# We pass history lines to fuzzel via stdin so user can pick one or type new text
# chosen_arg=$(printf '%s\n' "${history_lines[@]}" | fuzzel --dmenu --prompt "Select previous arg or type a new one" --placeholder "Pick or type argument")
chosen_arg=$(printf '%s\n' "${history_lines[@]}" | fuzzel --dmenu --placeholder "Pick or type argument")

# If empty, ask again or exit
if [ -z "$chosen_arg" ]; then
    echo "No argument chosen. Exiting." >&2
    exit 2
fi

# 3) Password prompt (hidden)
password=$(fuzzel --dmenu --prompt "> " --password --placeholder "Please type password")
# If user pressed Esc or cancelled, fuzzel returns non-zero -> exit
if [ -z "$password" ]; then
    echo "No password entered. Exiting." >&2
    exit 1
fi

# 4) Run huami.py with the chosen argument, with password exported as env var huami
# Quote carefully
echo "Running huami.py with arg: $chosen_arg"
# huami="$password" huami.py -- "$chosen_arg" | toclip
huami="$password" huami.py "$chosen_arg" | toclip

# 5) Update history: add chosen_arg to top, dedupe, limit size
# Use a temporary file for atomic update
tmpfile="$(mktemp)"
{
    printf '%s\n' "$chosen_arg"
    # append existing, skip lines equal to chosen_arg (dedupe)
    awk -v s="$chosen_arg" 'tolower($0)!=tolower(s)' "$HISTORY_FILE"
} | awk 'NF' | sed -n '1,'"$MAX_HISTORY"'p' > "$tmpfile" && mv "$tmpfile" "$HISTORY_FILE"

echo "Result copied to clipboard. History updated."

# vim:sw=4:ts=4:et:
