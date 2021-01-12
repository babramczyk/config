dotfiles_dir=$HOME/src/personal/dotfiles


##############################################################
# Imports
##############################################################

# The generated file that comes from oh-my-zsh
source $dotfiles_dir/.zshrc__generated
# Private stuff (keys, company-specific, etc.)
source $dotfiles_dir/.zshrc__private
source $dotfiles_dir/.zshrc__aliases

##############################################################
# PATH shenanigans
##############################################################

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH

# Setting PATH for mongodb
PATH="$HOME/mongodb/bin:${PATH}"
export PATH

# Setting PATH for Go executables
PATH="$HOME/go/bin:${PATH}"
export PATH

##############################################################
# Shell prompt
##############################################################

# Puts a new line after all prompts
precmd() {
  precmd() {
    echo
  }
}

# Two-line prompt with emoji
# Source: https://github.com/kentcdodds/dotfiles/blob/master/.zshrc
function random_element {
  declare -a array=("$@")
  r=$((RANDOM % ${#array[@]}))
  printf "%s\n" "${array[$r]}"
}
function random_emoji () {
  printf "$(random_element 😅 👽 🔥 👻 ⛄ 👾 🍔 😄 🍰 🐑 😎 🏎 🤖 😇 😼 💪 🦄 🥓 🌮 🎉 💯 ⚛️ 🐠 🐳 🐿 🥳 🤩 🤯 🤠 👨‍💻 🦸‍ 🧝‍ 🧞‍ 🧙‍ 👨‍🚀 👨‍🔬 🕺 🦁 🐶 🐵 🐻 🦊 🐙 🦎 🦖 🦕 🦍 🦈 🐊 🦂 🐍 🐢 🐘 🐉 🦚 ✨ ☄️ ⚡️ 💥 💫 🧬 🔮 ⚗️ 🎊 🔭 ⚪️ 🔱)"
}
PROMPT="$PROMPT"$'\n'"$(random_emoji)  "

##############################################################
# FZF
##############################################################

# fzf autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_EXCLUDE_GLOB="**/{node_modules,.git,.Trash,Library,Music,.node-gyp,.npm}"

export FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD 2>/dev/null || fd --hidden --follow --exclude='$FZF_EXCLUDE_GLOB'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude='$FZF_EXCLUDE_GLOB'"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude=$FZF_EXCLUDE_GLOB . $1
}
_fzf_compgen_path() {
  # If it's a git repo, only search for files tracked by git
  # Otherwise, just use fd
  git ls-tree -r --name-only HEAD 2>/dev/null $1 || fd --type f --hidden --follow --exclude=$FZF_EXCLUDE_GLOB . $1
}

##############################################################
# Navigation
##############################################################

# When typing a command that can't be executed, and the command is the name of the directory, cd into it. Also works with autocomplete
# Source: http://zsh.sourceforge.net/Doc/Release/Options.html
setopt auto_cd

cdpath=($HOME/src $HOME/playground $HOME/src/personal)

# Show named and cdpath directories in autocomplete suggestions
# Source: https://superuser.com/questions/515633/my-zsh-autocompletion-for-cdpath-stopped-working
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
  'local-directories named-directories path-directories'

##############################################################
# Miscellaneous setup
##############################################################

# Load sandboxd to lazy load some things
# Source: https://github.com/benvan/sandboxd
# See .sandboxrc for details
source $dotfiles_dir/bin/sandboxd

# NEXT_MACHINE: Make sure nvm is installed correctly. When homebrew installs it, it might try to put similar lines in this file (but we don't want it to, because we're making our own modifications)
export NVM_DIR="$HOME/.nvm"
# We're using `sandboxd` above to lazy load nvm instead of loading it right here
# [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
# [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
