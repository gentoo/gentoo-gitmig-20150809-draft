# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tkmoo/tkmoo-0.3.32.ebuild,v 1.8 2004/11/05 05:33:09 josejx Exp $

inherit games eutils

MY_PN=${PN/moo/MOO-light}
MY_P=${P/moo/MOO-light}
S=${WORKDIR}/${MY_P}

DESCRIPTION="MOO Client written in Tcl/Tk"
SRC_URI="http://www.awns.com/tkMOO-light/Source/${MY_P}.tar.gz"
HOMEPAGE="http://www.awns.com/tkMOO-light/"
IUSE=""

LICENSE="tkMOO"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

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
		TKMOO_LIB_DIR=${GAMES_LIBDIR}/${MY_PN} \
		TKMOO_BIN_DIR=${GAMES_BINDIR} \
		|| die
}

src_install() {
	make \
		TKMOO_LIB_DIR=${D}/${GAMES_LIBDIR}/${MY_PN} \
		TKMOO_BIN_DIR=${D}/${GAMES_BINDIR} \
		install \
		|| die
	dodoc README INSTALL.unix dot.tkmoolightrc bugsmail.txt
	ln -s tkMOO-lite ${D}/${GAMES_BINDIR}/tkmoo
	prepgamesdirs
}
