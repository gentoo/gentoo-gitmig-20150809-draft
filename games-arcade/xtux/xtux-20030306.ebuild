# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xtux/xtux-20030306.ebuild,v 1.4 2004/04/16 07:17:53 avenj Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="Multiplayer Gauntlet-style arcade game"
HOMEPAGE="http://xtux.sourceforge.net/"
SRC_URI="mirror://sourceforge/xtux/xtux-src-${PV}.tar.gz"

KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	for f in src/{client,common,server}/Makefile ; do
		sed -i \
			-e "s:-g -Wall -O2:${CFLAGS}:" ${f} \
				|| die "sed ${F} failed"
	done
	emake DATADIR="${GAMES_DATADIR}/xtux/data" || die "emake failed"
}

src_install () {
	dogamesbin xtux tux_serv
	dodir ${GAMES_DATADIR}/xtux
	cp -r data ${D}/${GAMES_DATADIR}/xtux/
	dodoc AUTHORS CHANGELOG README README.GGZ doc/*
	prepgamesdirs
}
