# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/c2ps/c2ps-4.0.ebuild,v 1.13 2006/01/06 13:51:54 blubb Exp $

DESCRIPTION="Generates a beautified ps document from a source file (c/c++)"
HOMEPAGE="http://www.cs.technion.ac.il/users/c2ps"
SRC_URI="http://www.cs.technion.ac.il/users/c2ps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~ppc-macos ~sparc x86"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/man/man1
	make PREFIX=${D}/usr install || die
	dodoc COPYING README
}
