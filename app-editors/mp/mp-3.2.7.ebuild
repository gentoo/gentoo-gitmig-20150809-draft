# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.2.7.ebuild,v 1.7 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="the definitive text editor"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://triptico.dhis.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/glibc
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
