#!/bin/sh
if [ ! -e ~/.armagetron ]; then
	mkdir ~/.armagetron{,/config,/log,/var}
	ln -s GAMES_DATADIR/armagetron/config/{{default,aiplayers}.cfg,master.srv} ~/.armagetron/config/
	cp GAMES_DATADIR/armagetron/config/settings.cfg ~/.armagetron/config/
	ln -s GAMES_DATADIR/armagetron/{arenas,models,moviesounds,textures,language,moviepack,sound} ~/.armagetron/
fi
cd ~/.armagetron
GAMES_PREFIX_OPT/armagetron/armagetron "$@"
