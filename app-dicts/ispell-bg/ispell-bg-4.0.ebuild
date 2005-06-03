# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-bg/ispell-bg-4.0.ebuild,v 1.1 2005/06/03 10:57:04 arj Exp $

DESCRIPTION="Bulgarian dictionary for ispell"
SRC_URI="mirror://sourceforge/bgoffice/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/bgoffice"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-text/ispell"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e s/DATA_DIR=.*$// Makefile > Makefile1
	rm Makefile
	mv Makefile1 Makefile
}

src_compile() {
	make || die
}

src_install () {
	DATA_DIR=${D} make install || die

	insinto /usr/lib/ispell
	doins ${D}/bulgarian.aff ${D}/bulgarian.hash
}
