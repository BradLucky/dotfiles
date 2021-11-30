#!/bin/zsh

function doIt() {
	for file in .[^.]*; do
		ln -s "$file" ~/"$file";
	done;
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
	doIt;
else
	read "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
	echo "";
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

# if [ "$1" == "--force" -o "$1" == "-f" ]; then
# 	doIt;
# else
# 	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
# 	echo "";
# 	if [[ $REPLY =~ ^[Yy]$ ]]; then
# 		doIt;
# 	fi;
# fi;
# unset doIt;
