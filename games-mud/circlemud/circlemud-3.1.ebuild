# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/circlemud/circlemud-3.1.ebuild,v 1.2 2004/01/30 10:11:46 vapier Exp $

inherit games

DESCRIPTION="a multi-user dungeon game system server"
HOMEPAGE="http://www.circlemud.org/"
SRC_URI="ftp://ftp.circlemud.org/pub/CircleMUD/${PV/.*}.x/circle-${PV}.tar.bz2"

LICENSE="circlemud"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	dev-libs/openssl"

S=${WORKDIR}/circle-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	touch .accepted
	sed -i 's:^read.*::' licheck

	# make circlemud fit into Gentoo nicely
	sed -i "s:\"lib\":\"${GAMES_DATADIR}/${PN}\":g" config.c || die
	sed -i "s:\(LOGNAME = \)NULL:\1\"${GAMES_LOGDIR}/${PN}.log\":g" config.c || die
	sed -i "s:etc/:${GAMES_SYSCONFDIR}/${PN}/:g" db.h || die

	# now lets rename binaries (too many are very generic)
	sed -i "s:\.\./bin/autowiz:${PN}-autowiz:" limits.c || die
}

src_compile() {
	egamesconf || die
	cd src
	emake || die
}

src_install() {
	for bin in autowiz delobjs listrent mudpasswd play2to3 purgeplay \
	           shopconv showplay sign split wld2html ; do
		newgamesbin bin/${bin} ${PN}-${bin}
	done
	dogamesbin bin/circle

	dodir ${GAMES_DATADIR}/${PN}
	cp -r lib/*  ${D}/${GAMES_DATADIR}/${PN}/ || die

	insinto ${GAMES_SYSCONFDIR}/${PN}
	doins lib/etc/*

	dodoc doc/{README.UNIX,*.pdf,*.txt} ChangeLog FAQ README release_notes.${PV}.txt
	prepgamesdirs
	fperms 770 ${GAMES_SYSCONFDIR}/${PN}/players
}
