# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.5.8.ebuild,v 1.1 2003/09/10 05:27:31 vapier Exp $

inherit games

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://freesoftware.fsf.org/download/liquidwar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">media-libs/allegro-4.0"

src_compile() {
	econf --disable-doc-ps --disable-doc-pdf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	cd ${D}/usr/games
	mkdir bin
	mv liquidwar liquidwar-server bin/
	rm -rf ${D}/usr/bin

	prepgamesdirs
}
