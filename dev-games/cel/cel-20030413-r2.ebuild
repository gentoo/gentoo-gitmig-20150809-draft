# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-20030413-r2.ebuild,v 1.1 2003/07/13 03:13:40 vapier Exp $

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
CS_PREFIX=${GAMES_PREFIX_OPT}/crystal

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-install.patch
}

src_compile() {
	./autogen.sh || die
	PATH="${CEL_PREFIX}/bin:${PATH}" ./configure --prefix=${CEL_PREFIX} --with-cs-prefix=${CEL_PREFIX} || die
	jam || die
}

src_install() {
	sed -i -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex
	# attention don't put a / between ${D} and ${CEL_PREFIX} jam has a bug where
	# it fails with 3 following slashes.
	jam -sFILEMODE=0640 -sEXEMODE=0750 -sprefix=${D}${CEL_PREFIX} install || die
	dogamesbin cel.cex
	prepgamesdirs
}
