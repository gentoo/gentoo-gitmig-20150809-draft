#!/bin/bash

case "$1" in
    install)
	sed -i "s:^\(AuthUserFile \).*$:\1${MY_INSTALLDIR}/admin/.htpasswd:gI" ${MY_INSTALLDIR}/admin/.htaccess || exit
	;;
    *)
	# Nothing to do for clean up
	;;
esac
