#!/bin/bash

case "$1" in
	install)
		sed -i "s|C:/apache/htdocs/dotproject|${MY_INSTALLDIR}|g;" ${MY_INSTALLDIR}/includes/config.php
		;;

	# nothing to do when we clean
esac
