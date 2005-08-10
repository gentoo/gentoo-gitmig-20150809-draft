# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/c2ps/c2ps-4.0.ebuild,v 1.11 2005/08/10 15:37:35 blubb Exp $

DESCRIPTION="Generates a beautified ps document from a source file (c/c++)"
HOMEPAGE="http://www.cs.technion.ac.il/users/c2ps"
SRC_URI="http://www.cs.technion.ac.il/users/c2ps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc ~sparc x86"
IUSE=""

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin /usr/man/man1
	make PREFIX=${D}/usr install || die
	dodoc COPYING README
}
