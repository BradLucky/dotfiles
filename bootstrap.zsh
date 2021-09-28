#!/bin/zsh

git pull origin main;

function doIt() {
	for file in .[^.]*; do
		ln -s "$file" ~/"$file";
	done;
	source ~/.zshrc 1>/dev/null 2>&1;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
