# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/chesstask/chesstask-1.3.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $


S=${WORKDIR}/${PN}1_3
IUSE=""
SLOT="0"
DESCRIPTION="An editor for chess problems. It will generate PostScript and HTML files."
SRC_URI="mirror://sourceforge/chesstask/ChessTask1_3src.zip"
HOMEPAGE="http://chesstask.sourceforge.net/"
KEYWORDS="~ppc"
LICENSE="GPL-2"
DEPEND=">=x11-libs/qt-3
		app-text/tetex"

src_unpack() {
	unpack ${A}
	cd ${S} || die "no such directory ${S}"
	patch -p1 Makefile < ${FILESDIR}/Makefile-1.3.diff || die "Failed to apply patch"
}


src_compile() {
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/bin
	cp ${S}/ChessTask ${D}/usr/bin
}
