# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.2.3.ebuild,v 1.3 2004/05/31 19:21:32 vapier Exp $

DESCRIPTION="Another Password Generator"
HOMEPAGE="http://www.adel.nursat.kz/apg/"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	cp Makefile Makefile.orig
	sed -e 's,^#\(CS_LIBS = -lnsl\)$,\1,' Makefile.orig > Makefile

	emake standalone || die "compile problem"
}

src_install() {
	exeinto /usr/bin ; doexe apg apgbfm
	dodoc CHANGES INSTALL README THANKS TODO
	cd ${S}/doc
	doman man/apg.1
	dodoc APG_TIPS pronun.txt rfc0972.txt rfc1750.txt
}
