#!/bin/zsh

# Setup sensible MacOS defaults and settings
./.macos

# Install XCode first to circumvent future dependencies
xcode-select --install

# Install Rosetta 2 as it is required by Logitech-Options
sudo softwareupdate --install-rosetta

# This installs homebrew itself, and also the command line tools in silent mode
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to your PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/brad/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install everything in Brewfile
brew bundle

# Load preferences for iTerm
#defaults read com.googlecode.iterm2

# Use pyenv to install the latest version of Python and make it the default
latest_python=$(pyenv install --list | grep -v - | grep "\." | grep -v rc | grep -v b | tail -1 | xargs)
pyenv install $latest_python
pyenv global $latest_python

IFS=. read major minor patch <<< $latest_python

# Install Vundle and configured packages
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -E -s -u ~/.vimrc +PluginInstall +qall
/usr/local/bin/python$major.$minor ~/.vim/bundle/YouCompleteMe/install.py --all

unset latest_python major minor patch

# Install powerline-status and git
sudo -H /usr/bin/python3 -m pip install powerline-status
sudo -H /usr/bin/python3 -m pip install powerline-gitstatus

# Modify ripgrep to provide proper pagination
cd $(which rg | awk -F'/rg' '{print $1}')
mv rg rgo
echo "#\!/bin/sh\n\n$(pwd)/rgo -p \"\$@\" | less -RFX" > rg
chmod 766 rg

# Install gh extension "branch"
gh extension install mislav/gh-branch
