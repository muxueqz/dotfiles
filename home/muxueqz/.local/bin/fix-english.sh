#!/bin/bash
# auto_process.sh
# This script:
# 1. Runs on Wayland (check for $WAYLAND_DISPLAY).
# 2. Gets the current primary selection (auto-copied text).
# 3. Pipes that text to another script.
# 4. Copies the output of that script back to the primary clipboard.

# Ensure we are running in a Wayland session
if [ -z "$WAYLAND_DISPLAY" ]; then
  echo "Error: This script requires a Wayland session."
  exit 1
fi

# Get the currently selected text from the primary selection.
# Adjust '--primary' if you need the clipboard buffer instead.
selected_text=$(wl-paste --primary)

# Check if text was obtained
if [ -z "$selected_text" ]; then
  echo "No text selected. Please select some text first."
  exit 1
fi

# Process the text with your external script.
# Replace '/path/to/another_script.sh' with the actual path to your script.
prompt='Corrects English spelling and grammar errors with explanations, just output Corrected Sentence result, no explain, no header, no prefix:'
processed_output=$(echo "$selected_text" | 
  ask_ai.py "$prompt"
)

# Copy the processed output back to the primary selection.
echo "$processed_output" | wl-copy
wtype $(wl-paste)
notify-send "fix-english.sh" "finished:$(wl-paste)"
