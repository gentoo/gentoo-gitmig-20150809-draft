# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Tom Bevan tom@regex.com.au
# $Header: /var/cvsroot/gentoo-x86/app-misc/chesstask/chesstask-1.3.ebuild,v 1.1 2003/02/23 17:57:00 pvdabeel Exp $


S=${WORKDIR}/${PN}1_3

DESCRIPTION="An editor for chess problems. It will generate PostScript and HTML files."

SRC_URI="http://telia.dl.sourceforge.net/sourceforge/chesstask/ChessTask1_3src.zip"
HOMEPAGE="http://chesstask.sourceforge.net/"

KEYWORDS="~ppc"

# License of the package. This must match the name of file(s) in
# /usr/portage/licenses/. For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE=""

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
