#!/bin/sh
if [ ! -e ~/.armagetron ]; then
	mkdir ~/.armagetron{,/config,/log,/var}
	ln -s DATADIR/config/{{default,aiplayers}.cfg,master.srv} ~/.armagetron/config/
	cp DATADIR/config/settings.cfg ~/.armagetron/config/
	ln -s DATADIR/{arenas,models,moviesounds,textures,language,moviepack,sound} ~/.armagetron/
fi
cd ~/.armagetron
BINDIR/armagetron "$@"
