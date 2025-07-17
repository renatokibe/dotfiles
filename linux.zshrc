# install gems in user home in manjrao
export GEM_HOME="$(gem env user_gemhome)"

# macos like pbcopy and pbpaste aliases
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
