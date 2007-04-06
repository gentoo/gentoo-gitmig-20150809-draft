# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xrick/xrick-021212-r1.ebuild,v 1.12 2007/04/06 01:01:07 nyhm Exp $

inherit eutils games

DESCRIPTION="Clone of the Rick Dangerous adventure game from the 80's"
SRC_URI="http://www.bigorno.net/xrick/${P}.tgz"
HOMEPAGE="http://www.bigorno.net/xrick/"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="mirror" # bug #149097

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./xrick.6.gz

	sed -i \
		-e "/^run from/d" \
		-e "/data.zip/ s:the directory where xrick is:$(games_get_libdir)/${PN}.:" \
		xrick.6 || die "sed xrick.6 failed"

	sed -i \
		-e "s:data.zip:$(games_get_libdir)/${PN}/data.zip:" \
		src/xrick.c || die "sed xrick.c failed"

	sed -i \
		-e "s/-g -ansi -pedantic -Wall -W -O2/${CFLAGS}/" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin xrick || die "dogamesbin failed"
	insinto "$(games_get_libdir)"/${PN}
	doins data.zip || die "doins failed"
	newicon src/xrickST.ico ${PN}.ico
	make_desktop_entry ${PN} ${PN} /usr/share/pixmaps/${PN}.ico
	dodoc README KeyCodes
	doman xrick.6
	prepgamesdirs
}
