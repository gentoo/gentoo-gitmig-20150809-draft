#!/bin/bash
#
# starts Armagetron Advanced from the installation directory

GAMES_LIBDIR="@GAMES_LIBDIR@/armagetronad"
GAMES_DATADIR="@GAMES_DATADIR@"
GAMES_SYSCONFDIR="@GAMES_SYSCONFDIR@"
PN=armagetronad

if test ! -r "${HOME}"/.armagetronad ; then
	mkdir "${HOME}"/.armagetronad

	if test -r "${HOME}"/.ArmageTronrc ; then
		# migrage very old configuration
		echo "Porting very old configuration..."
		mkdir "${HOME}"/.armagetronad/var
		mv "${HOME}"/.ArmageTronrc "${HOME}"/.armagetronad/var/user.cfg
	fi
fi

if test ! -r "${HOME}"/.armagetronad/var ; then
	#migrate old configuration
	files=$( find "${HOME}"/.armagetronad -type f -maxdepth 1 )

	mkdir "${HOME}"/.armagetronad/var
	if test "$files" != "" ; then
		echo "Porting old configuration..."
		mv $files "${HOME}"/.armagetronad/var
	fi
fi

exec \
"${GAMES_LIBDIR}"/${PN} \
	--datadir "${GAMES_DATADIR}"/${PN} \
	--configdir "${GAMES_SYSCONFDIR}"/${PN} \
	--userdatadir "${HOME}"/.armagetronad "$@"
