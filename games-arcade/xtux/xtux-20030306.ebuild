# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xtux/xtux-20030306.ebuild,v 1.8 2004/08/30 23:39:58 dholm Exp $

inherit games

DESCRIPTION="Multiplayer Gauntlet-style arcade game"
HOMEPAGE="http://xtux.sourceforge.net/"
SRC_URI="mirror://sourceforge/xtux/xtux-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

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
