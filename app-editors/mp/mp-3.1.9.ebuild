# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.1.9.ebuild,v 1.13 2004/06/27 22:16:46 vapier Exp $

DESCRIPTION="the definitive text editor"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://triptico.dhis.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	make install PREFIX=${D}/usr || die
	dodoc AUTHORS ChangeLog README
	dohtml README.html doc/mp_api.html
}
