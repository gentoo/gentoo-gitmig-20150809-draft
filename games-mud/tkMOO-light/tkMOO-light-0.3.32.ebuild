# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tkMOO-light/tkMOO-light-0.3.32.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

inherit games eutils

DESCRIPTION="MOO Client written in TK"
SRC_URI="http://www.awns.com/tkMOO-light/Source/${P}.tar.gz"
HOMEPAGE="http://www.awns.com/tkMOO-light/"

LICENSE="tkMOO"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile-noclean.patch
}

src_compile() {
	emake \
		WISH="`which wish`" \
		TKMOO_LIB_DIR=${GAMES_LIBDIR}/${PN} \
		TKMOO_BIN_DIR=${GAMES_BINDIR} \
		|| die
}

src_install() {
	make \
		TKMOO_LIB_DIR=${D}/${GAMES_LIBDIR}/${PN} \
		TKMOO_BIN_DIR=${D}/${GAMES_BINDIR} \
		install \
		|| die
	dodoc README INSTALL.unix dot.tkmoolightrc bugsmail.txt
	prepgamesdirs
}
