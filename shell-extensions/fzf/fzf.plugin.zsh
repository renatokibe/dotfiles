#general fzf config
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--layout=reverse --color=bg+:#242933,bg:-1,spinner:#81a1c1,hl:#5e81ac,fg:#d8dee9,header:#616e88,info:#8fbcbb,pointer:#81a1c1,marker:#a3be8c,fg+:#e5e9f0,prompt:#8fbcbb,hl+:#5e81ac,border:#5e81ac,gutter:-1'
export FZF_TMUX_OPTS="-p"
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_OPTS=""
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# forgit - use tmux popup
export FORGIT_FZF_DEFAULT_OPTS="--tmux center,50%,50%"

# enhancd
export ENHANCD_FILTER="$FZF_BIN_PATH"

export FZF_BIN_PATH='fzf-tmux -p --layout=reverse'

# Initialize zoxide (replaces zsh-z and fzf-z plugins)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"

  # Bind Ctrl+G to zoxide interactive mode using fzf-tmux popup (replaces fzf-z)
  function __zoxide_zi_widget() {
    local result=$(zoxide query -l | fzf-tmux -p --layout=reverse --preview 'eza --color=always {}' --preview-window=right:50%)
    if [ -n "$result" ]; then
      cd "$result"
    fi
    zle reset-prompt
    zle redisplay
  }
  zle -N __zoxide_zi_widget
  bindkey '^g' __zoxide_zi_widget
fi
