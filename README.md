# bradlucky’s dotfiles

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the dotfiles to your home folder.

```shell
git clone https://github.com/bradlucky/dotfiles.git && cd dotfiles && source bootstrap.zsh
```

To update, `cd` into your local `dotfiles` repository and then:

```shell
source bootstrap.zsh
```

Alternatively, to update while avoiding the confirmation prompt:

```shell
set -- -f; source bootstrap.zsh
```

To completely set up a new machine, setup.zsh will do *all the thing*:

```shell
source setup.zsh
```

### Git-free install

To acquire these dotfiles without Git:

```shell
cd; mkdir dotfiles && cd dotfiles; curl -#L https://github.com/bradlucky/dotfiles/tarball/main | tar -xzv --strip-components 1
```

Note: Git will be installed with the Homebrew formulae installations.

To update later on, just run that command again.

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/mathiasbynens/dotfiles/blob/aff769fd75225d8f2e481185a71d5e05b76002dc/.aliases#L21-L26)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```shell
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```shell
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Brad Luczywo"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="sub@cheezer.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/mathiasbynens/dotfiles/fork) instead, though.

### Set up new computer

When setting up a new Mac, you can set defaults and install programs:

```shell
source setup.zsh
```

This will apply the sensible macOS defaults within `.macos` and will install the Homebrew formulae within `Brewfile`. If you want to do those separately, you can:

#### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```shell
./.macos
```

#### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```shell
brew bundle
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is shell/Git completion: the dotfiles use a special version from Homebrew.

## Thanks to…

* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Michael Friedrich's dotfile](https://gitlab.com/dnsmichi/dotfiles/-/tree/main)
