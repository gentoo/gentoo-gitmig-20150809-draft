# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.3.0b.ebuild,v 1.10 2004/10/05 02:58:10 pvdabeel Exp $

DESCRIPTION="Another Password Generator"
HOMEPAGE="http://www.adel.nursat.kz/apg/"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc amd64 hppa"
IUSE=""

DEPEND="virtual/libc"

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
	dobin apg apgbfm bfconvert/bfconvert || die
	dodoc CHANGES INSTALL README THANKS TODO
	cd doc
	doman man/apg.1 man/apgbfm.1
	dodoc APG_TIPS pronun.txt rfc0972.txt rfc1750.txt
}
