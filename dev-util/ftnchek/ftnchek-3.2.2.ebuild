# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ftnchek/ftnchek-3.2.2.ebuild,v 1.3 2004/03/13 01:42:49 mr_bones_ Exp $

DESCRIPTION="Static analyzer a la 'lint' for Fortran 77"
HOMEPAGE="http://www.dsm.fordham.edu/~ftnchek/"
SRC_URI="http://www.dsm.fordham.edu/~${PN}/download/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc FAQ INSTALL LICENSE PATCHES README ToDo
	dohtml html/*
	dodir /usr/share/${PN}
	cp -r test ${D}/usr/share/${PN}
}
