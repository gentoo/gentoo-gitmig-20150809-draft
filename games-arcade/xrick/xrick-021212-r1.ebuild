# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xrick/xrick-021212-r1.ebuild,v 1.10 2006/09/25 18:18:02 mr_bones_ Exp $

inherit games

DESCRIPTION="Clone of the Rick Dangerous adventure game from the 80's"
SRC_URI="http://www.bigorno.net/xrick/${P}.tgz"
HOMEPAGE="http://www.bigorno.net/xrick/"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="mirror" # bug #149097

DEPEND=">=media-libs/libsdl-1.2
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip xrick.6.gz || die "gunzip failed"

	sed -i \
		-e "/^run from/d" \
		-e "/data.zip/ s:the directory where xrick is:${GAMES_LIBDIR}/${PN}.:" \
		xrick.6 || die "sed xrick.6 failed"

	sed -i \
		-e "s:data.zip:${GAMES_LIBDIR}/${PN}/data.zip:" \
		src/xrick.c || die "sed xrick.c failed"

	sed -i \
		-e "s/-g -ansi -pedantic -Wall -W -O2/${CFLAGS}/" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin xrick || die
	insinto "${GAMES_LIBDIR}/${PN}"
	doins data.zip
	dodoc README KeyCodes
	doman xrick.6
	prepgamesdirs
}
