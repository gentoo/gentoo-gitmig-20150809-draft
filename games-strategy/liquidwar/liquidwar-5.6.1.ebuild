# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/liquidwar/liquidwar-5.6.1.ebuild,v 1.1 2004/01/13 06:17:30 mr_bones_ Exp $

inherit games flag-o-matic

DESCRIPTION="unique multiplayer wargame"
HOMEPAGE="http://www.ufoot.org/liquidwar/"
SRC_URI="http://liquidwar.sunsite.dk/archive/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">media-libs/allegro-4.0"

src_compile() {
	# Fixes build problem with gcc3 and -march=pentium4
	replace-flags "-march=pentium4" "-march=pentium3"

	# needs to be econf and not egamesconf.  Otherwise we end up
	# with too many /games/ all over the place.
	econf --disable-doc-ps --disable-doc-pdf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dogamesbin ${D}/usr/games/{liquidwar,liquidwar-server,liquidwar-mapgen} || \
		die "dogamesbin failed"
	rm -f ${D}/usr/games/{liquidwar,liquidwar-server,liquidwar-mapgen}
	rm -rf ${D}/usr/bin
	prepgamesdirs
}
