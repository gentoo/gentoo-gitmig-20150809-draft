# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xtux/xtux-20030306.ebuild,v 1.1 2003/09/10 19:29:22 vapier Exp $

inherit games

DESCRIPTION="Multiplayer Gauntlet-style arcade game"
HOMEPAGE="http://xtux.sourceforge.net/"
SRC_URI="mirror://sourceforge/xtux/xtux-src-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_compile() {
	for f in src/{client,common,server}/Makefile ; do
		sed -i \
			-e "s:-g -Wall -O2:${CFLAGS}:" ${f} || \
				die "sed ${F} failed"
	done
	emake DATADIR=${GAMES_DATADIR}/xtux/data || die
}

src_install () {
	dogamesbin xtux tux_serv

	dodir ${GAMES_DATADIR}/xtux
	cp -r data ${D}/${GAMES_DATADIR}/xtux/

	dodoc AUTHORS CHANGELOG COPYING README README.GGZ doc/*

	prepgamesdirs
}
