#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine. From https://gist.github.com/codeinthehole/26b37efa67041e1307db
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# <none, for now>
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

source bootstrap-helpers.sh

clear
printf "Hi, $USER! 👋\n"
printf "Let's get you set up... 👨‍💻\n"
# For dramatic effect...
sleep 2s


#######################################
# Symlinks
#######################################
log "Symlinking dotfiles to \$HOME: $HOME"

install_dotfile ".zshrc"
install_dotfile ".gitconfig"
install_dotfile ".vimrc"

#######################################
# MacOS installs
#######################################
log "Updating MacOS apps"
# TODO: Uncomment this if I'm ever on a non-enterprise machine and can acutally use the latest macOS 🤓
# softwareupdate -i -a

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    log "Homebrew: Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

log "Homebrew: Updating recipes..."
brew update

log "Homebrew: Installing and upgrading packages..."
brew bundle

#######################################
# MacOS
#######################################
source bootstrap-macos.sh

#######################################
# Fin
#######################################

log "All done. Have fun! 🚀"