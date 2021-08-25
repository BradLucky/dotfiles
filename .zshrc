# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Use the pyenv-defined Python version at a system level
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Initialize Powerline-status for command line theme
powerline=$(/usr/bin/python3 -m pip show powerline-status | grep Location: | sed -e "s-Location: --g")
. $powerline/powerline/bindings/zsh/powerline.zsh
unset powerline

# Set up the "zsh Completion System"
autoload -U compinit && compinit

# Enable argcomplete support in Zsh for scripts
# https://kislyuk.github.io/argcomplete/#zsh-support
autoload -U bashcompinit
bashcompinit

# Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
