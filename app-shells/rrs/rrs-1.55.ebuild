# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rrs/rrs-1.55.ebuild,v 1.3 2004/06/24 22:25:24 agriffis Exp $

DESCRIPTION="Reverse Remote Shell"
HOMEPAGE="http://www.cycom.se/dl/rrs"
SRC_URI="http://www.cycom.se/uploads/36/18/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
	virtual/glibc"

src_compile() {
	local target=""
	use ssl || target="-nossl"

	emake generic${target} \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin rrs
	dodoc CHANGES README
	doman rrs.1
}
