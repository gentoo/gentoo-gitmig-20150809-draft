# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.2.7.ebuild,v 1.4 2004/01/11 14:07:52 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mp, the definitive text editor"
SRC_URI="http://triptico.dhis.org/download/${P}.tar.gz"
HOMEPAGE="http://www.triptico.com/software/mp.html"

DEPEND="virtual/glibc
	sys-libs/ncurses"

RDEPEND="${DEPEND}
	dev-lang/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	make install PREFIX=${D}/usr || die
	dodoc AUTHORS ChangeLog COPYING README
	dohtml README.html doc/mp_api.html
}

