# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sbd/sbd-1.31.ebuild,v 1.4 2004/07/30 00:30:58 swegener Exp $

DESCRIPTION="Netcat-clone, designed to be portable and offer strong encryption"
HOMEPAGE="http://www.cycom.se/dl/sbd"
SRC_URI="http://www.cycom.se/uploads/114/31/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		UNIX_CFLAGS="" \
		UNIX_LDFLAGS="" \
		unix || die "emake failed"
}

src_install() {
	dobin sbd || die "dobin failed"
	dodoc CHANGES README || die "dodoc failed"
}
