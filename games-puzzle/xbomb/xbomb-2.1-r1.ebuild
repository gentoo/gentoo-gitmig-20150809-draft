# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.1-r1.ebuild,v 1.9 2004/11/22 05:18:19 vapier Exp $

inherit eutils games

DESCRIPTION="Minesweeper clone with hexagonal, rectangular and triangular grid"
HOMEPAGE="http://www.gedanken.demon.co.uk/xbomb/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/games/strategy/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

RDEPEND="virtual/x11
	virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.diff
	sed -i \
		-e "/^CFLAGS/ { s:=.*:=${CFLAGS}: }" \
		-e "s:/usr/bin:${GAMES_BINDIR}:" \
		${S}/Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e "s:/var/tmp:/var/games:g" \
		${S}/hiscore.c \
		|| die "sed hiscore.c failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README LSM
	dodir /var/games
	touch ${D}/var/games/xbomb{3,4,6}.hi || die "touch failed"
	fperms 664 /var/games/xbomb{3,4,6}.hi || die

	prepall
	prepgamesdirs
}
