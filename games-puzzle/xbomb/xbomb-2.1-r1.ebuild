# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.1-r1.ebuild,v 1.12 2005/10/31 08:46:44 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Minesweeper clone with hexagonal, rectangular and triangular grid"
HOMEPAGE="http://www.gedanken.demon.co.uk/xbomb/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/games/strategy/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}.diff
	sed -i \
		-e "/^CFLAGS/ { s:=.*:=${CFLAGS}: }" \
		-e "s:/usr/bin:${GAMES_BINDIR}:" \
		"${S}"/Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e "s:/var/tmp:/var/games:g" \
		"${S}"/hiscore.c \
		|| die "sed hiscore.c failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README LSM
	# FIXME: need to use GAMES_STATEDIR here
	dodir /var/games
	touch ${D}/var/games/xbomb{3,4,6}.hi || die "touch failed"
	fperms 664 /var/games/xbomb{3,4,6}.hi || die

	prepall
	prepgamesdirs
}
