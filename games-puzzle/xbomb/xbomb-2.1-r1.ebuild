# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.1-r1.ebuild,v 1.3 2004/02/03 20:50:09 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Minesweeper clone with hexagonal, rectangular and triangular grid"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/games/strategy/${P}.tgz"
HOMEPAGE="http://www.gedanken.demon.co.uk/xbomb/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.diff
	sed -i \
		-e "/^CFLAGS/ { s:=.*:=${CFLAGS}: }" \
		-e "s:/usr/bin:${GAMES_BINDIR}:" ${S}/Makefile || \
		die "sed Makefile failed"
	sed -i \
		-e "s:/var/tmp:/var/games:g" ${S}/hiscore.c || \
			die "sed hiscore.c failed"
}

src_compile() {
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc README LSM || die
	keepdir /var/games || die
	touch ${D}/var/games/xbomb{3,4,6}.hi || die "touch failed"
	fperms 664 /var/games/xbomb{3,4,6}.hi || die

	prepall
	prepgamesdirs
}
