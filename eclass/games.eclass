# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games.eclass,v 1.4 2002/11/05 19:55:30 vapier Exp $

# devlist: {bass,phoenix,vapier}@gentoo.org
# This is the games ebuild for standardizing the install of games ...
# you better have a *good* reason why you're *not* using games.eclass
# in an ebuild in app-games

ECLASS=games
INHERITED="$INHERITED $ECLASS"

export GAMES_PREFIX="/usr/games"
export GAMES_DATADIR="/usr/share/games/${PN}"
export GAMES_SYSCONFDIR="/etc/games/${PN}"
export GAMES_STATEDIR="/var/games"
export GAMES_PREFIX_OPT="/opt/${PN}"
export GAMES_GROUP="games"

egameconf() {
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

gameswrapper() {
	local olddtree=${DESTTREE}
	into ${GAMES_PREFIX}
	local cmd="do$1"; shift
	${cmd} $@
	into ${oldtree}
}

dogamebin() { gameswrapper bin $@; }
dogamesbin() { gameswrapper sbin $@; }
dogamelib() { gameswrapper lib $@; }
dogamelib.a() { gameswrapper lib.a $@; }
dogamelib.so() { gameswrapper lib.so $@; }
