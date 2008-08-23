# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rrs/rrs-1.70.ebuild,v 1.8 2008/08/23 18:30:46 maekke Exp $

DESCRIPTION="Reverse Remote Shell"
HOMEPAGE="http://www.cycom.se/dl/rrs"
SRC_URI="http://www.cycom.se/uploads/36/19/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
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
