# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.3.0b-r1.ebuild,v 1.4 2005/07/03 13:16:32 hansmi Exp $

inherit eutils

DESCRIPTION="Another Password Generator"
HOMEPAGE="http://www.adel.nursat.kz/apg/"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~sparc x86"
IUSE="cracklib"

DEPEND="virtual/libc
	cracklib? ( sys-libs/cracklib )"

src_unpack() {
	unpack ${A}
	chmod -R +w ${S}
	cd ${S}
	if use cracklib; then
		epatch ${FILESDIR}/${P}-cracklib.patch
	fi
}

src_compile() {
	sed -i 's,^#\(APG_CS_CLIBS += -lnsl\)$,\1,' Makefile

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
