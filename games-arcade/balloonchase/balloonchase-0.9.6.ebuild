# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/balloonchase/balloonchase-0.9.6.ebuild,v 1.8 2006/05/03 02:53:47 weeve Exp $

inherit eutils games

DESCRIPTION="Fly a hot air balloon and try to blow the other player out of the screen"
HOMEPAGE="http://koti.mbnet.fi/makegho/c/bchase/"
SRC_URI="http://koti.mbnet.fi/makegho/c/bchase/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo.patch"

	sed -i \
		-e "s:GENTOODIR:${GAMES_DATADIR}/${PN}:" src/main.c \
		|| die 'sed failed'
}

src_install() {
	dogamesbin balloonchase || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r images "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc README
	prepgamesdirs
}
