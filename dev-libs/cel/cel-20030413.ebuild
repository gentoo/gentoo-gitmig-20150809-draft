# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cel/cel-20030413.ebuild,v 1.2 2003/05/19 10:58:46 lordvan Exp $

inherit games

HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.gz"
DESCRIPTION="A game entity layer based on Crystal Space"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/crystalspace
	dev-util/jam
	!dev-libs/cel-cvs"

S=${WORKDIR}/${PN}

CEL_PREFIX=${GAMES_PREFIX_OPT}/crystal

src_compile() {
	./autogen.sh || die
	PATH="${CEL_PREFIX}/bin:${PATH}" ./configure --prefix=${CEL_PREFIX} || die
	jam || die
}

src_install() {
	sed -i -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex

	insinto ${CEL_PREFIX}
	doins `find include -iname '*.h'`

	into ${CEL_PREFIX}
	dolib.so *.so

	insinto ${CEL_PREFIX}/bin
	doins	cel.cex
	#dogamesbin cel.cex
	mv celtst ${D}/${CEL_PREFIX}/

	prepgamesdirs
}
