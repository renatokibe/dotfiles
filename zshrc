# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source ${HOME}/.functions
source ${HOME}/.exports
source ${HOME}/.path

source ${HOME}/.defaults
source ${HOME}/.aliases

if is_osx; then
  source ${HOME}/.osx
fi

if is_linux; then
  source ${HOME}/.linux.zshrc
fi

# source ${HOME}/.zshrc.zplug
source ${HOME}/.zshrc.zgenom
