# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.1.0.ebuild,v 1.3 2003/06/29 15:24:07 aliz Exp $

DESCRIPTION="Another Password Generator"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"
HOMEPAGE="http://www.adel.nursat.kz/apg/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"
IUSE=""
RDEPEND=""

DEPEND="virtual/glibc"

src_compile() {
	cp Makefile Makefile.orig
	sed -e 's,^#\(CS_LIBS = -lnsl\)$,\1,' Makefile.orig > Makefile

	emake standalone || die "compile problem"
}

src_install() {
	exeinto /usr/bin ; doexe apg apgbfm
	dodoc CHANGES COPYING INSTALL README THANKS TODO
	cd ${S}/doc
	doman man/apg.1
	dodoc APG_TIPS pronun.txt rfc0972.txt  rfc1750.txt
}
