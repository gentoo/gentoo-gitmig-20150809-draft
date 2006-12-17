# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apg/apg-2.3.0b-r2.ebuild,v 1.6 2006/12/17 18:01:29 voxus Exp $

inherit eutils

DESCRIPTION="Another Password Generator"
HOMEPAGE="http://www.adel.nursat.kz/apg/"
SRC_URI="http://www.adel.nursat.kz/apg/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~sparc x86"
IUSE="cracklib"

DEPEND="cracklib? ( sys-libs/cracklib )"

src_unpack() {
	unpack "${A}"
	chmod -R 0700 "${S}"
	cd ${S}
	if use cracklib; then
		epatch ${FILESDIR}/${P}-cracklib.patch
		epatch ${FILESDIR}/${PN}-glibc-2.4.patch
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
