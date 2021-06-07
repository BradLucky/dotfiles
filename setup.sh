# Setup sensible MacOS defaults and settings
./.macos

# Install XCode first to circumvent future dependencies
xcode-select --install

# This installs homebrew itself, and also the command line tools in silent mode
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install everything in Brewfile
brew bundle

# Install SauceCodePro nerd font
cd ~/Library/Fonts && { 
    curl -O 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf'
    cd -; }

# Load preferences for iTerm
defaults read com.googlecode.iterm2
