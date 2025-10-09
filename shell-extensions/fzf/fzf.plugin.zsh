#general fzf config
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--layout=reverse --color=bg+:#242933,bg:-1,spinner:#81a1c1,hl:#5e81ac,fg:#d8dee9,header:#616e88,info:#8fbcbb,pointer:#81a1c1,marker:#a3be8c,fg+:#e5e9f0,prompt:#8fbcbb,hl+:#5e81ac,border:#5e81ac,gutter:-1'
export FZF_TMUX_OPTS="-p"
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_OPTS=""
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# enhancd
export ENHANCD_FILTER="$FZF_BIN_PATH"

# fzf z config (ctrl-g)
export FZFZ_EXTRA_OPTS=""
export FZF_BIN_PATH='fzf-tmux -p --layout=reverse'
