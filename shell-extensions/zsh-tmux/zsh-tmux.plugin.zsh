# Auto-start tmux (replaces laggardkernel/zsh-tmux plugin)
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -z "$INSIDE_EMACS" ] && [ -z "$VSCODE_INJECTION" ]; then
  # Attach to session or create it (configurable via TMUX_AUTOSTART_SESSION)
  # Using -A flag: attach if exists, create if not (atomic operation)
  local session_name="${TMUX_AUTOSTART_SESSION:-kibe-b1ec9}"
  tmux new-session -A -s "$session_name"
fi
