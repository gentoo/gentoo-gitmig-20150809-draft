# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rrs/rrs-1.70.ebuild,v 1.1 2004/06/04 08:08:32 dragonheart Exp $

DESCRIPTION="Reverse Remote Shell"
HOMEPAGE="http://www.cycom.se/dl/rrs"
SRC_URI="http://www.cycom.se/uploads/36/19/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
