# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rrs/rrs-1.70.ebuild,v 1.7 2007/02/17 23:14:18 dragonheart Exp $

DESCRIPTION="Reverse Remote Shell"
HOMEPAGE="http://www.cycom.se/dl/rrs"
SRC_URI="http://www.cycom.se/uploads/36/19/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )
	virtual/libc"

src_compile() {
	local target=""
	use ssl || target="-nossl"

	sed -i -e "s/-s //g" Makefile
	emake generic${target} \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin rrs || die
	dodoc CHANGES README
	doman rrs.1
}
