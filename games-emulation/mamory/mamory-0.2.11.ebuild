# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit games

DESCRIPTION="rom management tools and library"
HOMEPAGE="http://mamory.sourceforge.net/"
SRC_URI="mirror://sourceforge/mamory/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha ~arm ~hppa ~mips ~sparc"

DEPEND=""
RDEPEND=""

src_compile() {
	egamesconf || die
	emake CFLAGS="${CFLAGS} -DNDEBUG" || die "emake failed"
}

src_install() {
	egamesinstall || die
	mv ${D}/${GAMES_PREFIX}/include ${D}/usr/
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	dohtml DOCS/mamory.html || die "dohtml failed"
	prepgamesdirs
}
