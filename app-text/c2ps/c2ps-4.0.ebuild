# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/c2ps/c2ps-4.0.ebuild,v 1.3 2003/07/29 13:52:52 lanius Exp $

DESCRIPTION="Generates a beautified ps document from a source file (c/c++)"
SRC_URI="http://www.cs.technion.ac.il/users/c2ps/${P}.tar.gz"
HOMEPAGE="http://www.cs.technion.ac.il/users/c2ps"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin /usr/man/man1
	make PREFIX=${D}/usr install || die
	dodoc COPYING README
}
