# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.1.9.ebuild,v 1.5 2002/08/14 18:36:02 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mp, the definitive text editor"
SRC_URI="http://triptico.dhis.org/download/${P}.tar.gz"
HOMEPAGE="http://www.triptico.com/software/mp.html"

DEPEND="virtual/glibc
	sys-libs/ncurses"

RDEPEND="${DEPEND}
	sys-devel/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	make install PREFIX=${D}/usr || die
	dodoc AUTHORS ChangeLog COPYING README
	dohtml README.html doc/mp_api.html
}
