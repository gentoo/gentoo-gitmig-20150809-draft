# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mamory/mamory-0.2.12.ebuild,v 1.2 2004/05/27 01:00:13 mr_bones_ Exp $

inherit games

DESCRIPTION="rom management tools and library"
HOMEPAGE="http://mamory.sourceforge.net/"
SRC_URI="mirror://sourceforge/mamory/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	egamesconf || die
	emake CFLAGS="${CFLAGS} -DNDEBUG" || die "emake failed"
}

src_install() {
	egamesinstall || die
	mv ${D}/${GAMES_PREFIX}/include ${D}/usr/ || die "mv failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml DOCS/mamory.html
	prepgamesdirs
}
