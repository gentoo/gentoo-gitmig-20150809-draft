# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games.eclass,v 1.8 2002/11/17 22:03:49 vapier Exp $

# devlist: {bass,phoenix,vapier}@gentoo.org
# This is the games ebuild for standardizing the install of games ...
# you better have a *good* reason why you're *not* using games.eclass
# in an ebuild in app-games

ECLASS=games
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_postinst

export GAMES_PREFIX="/usr/games"
export GAMES_PREFIX_OPT="/opt/${PN}"
export GAMES_DATADIR="/usr/share/games/${PN}"
export GAMES_SYSCONFDIR="/etc/games/${PN}"
export GAMES_STATEDIR="/var/games"
export GAMES_LIBDIR="/usr/games/lib"
export GAMES_BINDIR="/usr/games/bin"
export GAMES_ENVD="90games"
export GAMES_USER="root"
export GAMES_GROUP="games"

egamesconf() {
	if [ -x ./configure ] ; then
		./configure \
			--prefix=${GAMES_PREFIX} \
			--host=${CHOST} \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--datadir=${GAMES_DATADIR} \
			--sysconfdir=${GAMES_SYSCONFDIR} \
			--localstatedir=${GAMES_STATEDIR} \
			"$@" || die "egamesconf failed"
	else
		die "no configure script found"
	fi
}

egamesinstall() {
	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		make prefix=${D}${GAMES_PREFIX} \
		    mandir=${D}/usr/share/man \
		    infodir=${D}/usr/share/info \
		    datadir=${D}${GAMES_DATADIR} \
		    sysconfdir=${D}${GAMES_SYSCONFDIR} \
		    localstatedir=${D}${GAMES_STATEDIR} \
		    "$@" install || die "einstall failed"
	else
		die "no Makefile found" 
	fi
}

gameswrapper() {
	local oldtree=${DESTTREE}
	into ${GAMES_PREFIX}
	local cmd="do$1"; shift
	${cmd} $@
	into ${oldtree}
}

dogamesbin() { gameswrapper bin $@; }
dogamessbin() { gameswrapper sbin $@; }
dogameslib() { gameswrapper lib $@; }
dogameslib.a() { gameswrapper lib.a $@; }
dogameslib.so() { gameswrapper lib.so $@; }

gamesowners() { chown ${GAMES_USER}.${GAMES_ROOT} $@; }
gamesperms() { chmod ug+r,o-rwx $@; }

gamesenv() {
	echo "LDPATH=\"${GAMES_LIBDIR}\"" > /etc/env.d/${GAMES_ENVD}
	echo "PATH=\"${GAMES_BINDIR}\"" >> /etc/env.d/${GAMES_ENVD}
}

games_pkg_postinst() { gamesenv; }
