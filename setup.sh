# Setup sensible MacOS defaults and settings
./.macos

# Install XCode first to circumvent future dependencies
xcode-select --install

# This installs homebrew itself, and also the command line tools in silent mode
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Open up perms to /usr/local so that Homebrew can install all it needs to
sudo chown -R $(whoami) $(brew --prefix)/*

# Install everything in Brewfile
brew bundle

# Install SauceCodePro nerd font
cd ~/Library/Fonts && { 
    curl -O 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce Code Pro Nerd Font Complete.ttf'
    cd -; } &> /dev/null

# Load preferences for iTerm
#defaults read com.googlecode.iterm2

# Install Vundle and configured packages
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Use pyenv to install the latest version of Python and make it the default
latest_python=$(pyenv install --list | grep -v - | grep -v b | tail -1)
pyenv install $latest_python
pyenv global $latest_python
unset latest_python

# Install powerline-status and git
sudo -H /usr/bin/python3 -m pip install powerline-status
sudo -H /usr/bin/python3 -m pip install powerline-gitstatus

# Modify ripgrep to provide proper pagination
cd $(which rg | awk -F'/rg' '{print $1}')
mv rg rgo
echo "#\!/bin/sh\n\n$(pwd)/rgo -p \"\$@\" | less -RFX" > rg
chmod 766 rg
