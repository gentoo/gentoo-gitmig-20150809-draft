# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.3.0b.ebuild,v 1.4 2004/02/09 04:49:15 absinthe Exp $

DESCRIPTION="Another Password Generator"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"
HOMEPAGE="http://www.adel.nursat.kz/apg/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc amd64"
IUSE=""

DEPEND="virtual/glibc"
src_unpack() {
	unpack ${A}
	chmod -R +w ${S}
}

src_compile() {
	cp Makefile Makefile.orig
	sed -e 's,^#\(APG_CS_CLIBS += -lnsl\)$,\1,' Makefile.orig > Makefile

	emake standalone || die "compile problem"
	emake -C bfconvert || die "compile problem"
}

src_install() {
	dobin apg apgbfm bfconvert/bfconvert
	dodoc CHANGES COPYING INSTALL README THANKS TODO
	cd ${S}/doc
	doman man/apg.1 man/apgbfm.1
	dodoc APG_TIPS pronun.txt rfc0972.txt rfc1750.txt
}
