# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games.eclass,v 1.40 2003/07/10 02:03:39 vapier Exp $
#
# devlist: {bass,phoenix,vapier}@gentoo.org
#
# This is the games ebuild for standardizing the install of games ...
# you better have a *good* reason why you're *not* using games.eclass
# in an ebuild in app-games

inherit eutils

ECLASS=games
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_postinst src_compile pkg_setup

DESCRIPTION="Based on the ${ECLASS} eclass"
IUSE="dedicated"

export GAMES_PREFIX="/usr/games"
export GAMES_PREFIX_OPT="/opt"
export GAMES_DATADIR="/usr/share/games"
export GAMES_DATADIR_BASE="/usr/share" # some packages auto append 'games'
export GAMES_SYSCONFDIR="/etc/games"
export GAMES_STATEDIR="/var/games"
export GAMES_LIBDIR="/usr/games/lib"
export GAMES_BINDIR="/usr/games/bin"
export GAMES_ENVD="90games"
# if you want to use a different user/group than games.games,
# just add these two variables to your environment (aka /etc/profile)
export GAMES_USER="${GAMES_USER:-games}"
export GAMES_USER_DED="${GAMES_USER_DED:-games-ded}"
export GAMES_GROUP="${GAMES_GROUP:-games}"

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
	local cmd=$1; shift
	${cmd} $@
	into ${oldtree}
}

dogamesbin() { gameswrapper ${FUNCNAME/games} $@; }
dogamessbin() { gameswrapper ${FUNCNAME/games} $@; }
dogameslib() { gameswrapper ${FUNCNAME/games} $@; }
dogameslib.a() { gameswrapper ${FUNCNAME/games} $@; }
dogameslib.so() { gameswrapper ${FUNCNAME/games} $@; }
newgamesbin() { gameswrapper ${FUNCNAME/games} $@; }
newgamessbin() { gameswrapper ${FUNCNAME/games} $@; }

gamesowners() { chown ${GAMES_USER}.${GAMES_GROUP} $@; }
gamesperms() { chmod u+rw,g+r-w,o-rwx $@; }
prepgamesdirs() {
	for dir in ${GAMES_PREFIX} ${GAMES_PREFIX_OPT} ${GAMES_DATADIR} ${GAMES_SYSCONFDIR} \
			${GAMES_STATEDIR} ${GAMES_LIBDIR} ${GAMES_BINDIR} $@ ; do
		(
			gamesowners -R ${D}/${dir}
			find ${D}/${dir} -type d -print0 | xargs --null chmod 750
			find ${D}/${dir} -type f -print0 | xargs --null chmod o-rwx,g+r
		) >& /dev/null
	done
}

gamesenv() {
	echo "LDPATH=\"${GAMES_LIBDIR}\"" > /etc/env.d/${GAMES_ENVD}
	echo "PATH=\"${GAMES_BINDIR}\"" >> /etc/env.d/${GAMES_ENVD}
}

games_pkg_setup() {
	enewgroup ${GAMES_GROUP} 35
	enewuser ${GAMES_USER} 35 /bin/false /usr/games ${GAMES_GROUP}
	enewuser ${GAMES_USER_DED} 36 /bin/bash /usr/games ${GAMES_GROUP}
}

games_src_compile() {
	[ -x ./configure ] && { egamesconf || die "egamesconf failed"; }
	[ -e [Mm]akefile ] && { emake || die "emake failed"; }
}

# pkg_postinst function ... create env.d entry and warn about games group
games_pkg_postinst() {
	gamesenv
	echo
	ewarn "Remember, in order to play games, you have to"
	ewarn "be in the '${GAMES_GROUP}' group."
	einfo "See the usermod(8) manpage for more information."
	echo
}

# some games require cdrom's to install datafiles ...
# $1: directory to check for on cdrom
# after function call, cdrom should be in ${GAMES_CD}
games_get_cd() {
	export GAMES_CD=${GAMES_CDROM}
	if [ -z "${GAMES_CD}" ] ; then
		for mline in `mount | egrep -e '(iso|cdrom)' | awk '{print $3}'` ; do
			[ -d ${mline}/${1} ] && GAMES_CD=${mline}
		done
	fi
	[ ! -z "${GAMES_CD}" ] && einfo "Using ${GAMES_CD} as the data source"
}
# Pass a description of the cd to the function
games_verify_cd() {
	if [ -z "${GAMES_CD}" ] ; then
		echo
		eerror "You must mount the $* CD first!"
		echo
		ewarn "If you do not have the CD, but have the data files"
		ewarn "mounted somewhere on your filesystem, just export"
		ewarn "the variable GAMES_CDROM so that it points to the"
		ewarn "directory containing the files."
		echo
		die "You must provide the $* data before running the install"
	fi
}
