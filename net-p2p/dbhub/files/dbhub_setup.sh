#!/bin/bash
if test ! -d $HOME/.dbhub; then
	echo "creating config directory: $HOME/.dbhub"
	mkdir $HOME/.dbhub
	chmod 700 $HOME/.dbhub
else
	echo "$HOME/.dbhub already exists!"
fi
if test ! -d $HOME/.dbhub/scripts; then
	echo "creating script directory: $HOME/.dbhub/scripts"
	mkdir $HOME/.dbhub/scripts
	chmod 700 $HOME/.dbhub/scripts;
	echo "copying scripts..."
	for i in /usr/share/dbhub/scripts/*; do
		cp $i $HOME/.dbhub/scripts;
	done
else
	echo "$HOME/.dbhub/scripts already exists!"
fi
echo "done!"
