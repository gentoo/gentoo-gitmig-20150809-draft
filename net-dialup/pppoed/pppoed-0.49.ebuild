# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppoed/pppoed-0.49.ebuild,v 1.6 2007/05/06 08:06:19 genone Exp $

inherit linux-info eutils

DESCRIPTION="User space implementation of PPP over Ethernet"
HOMEPAGE="http://www.furryterror.org/~afong/pppoe/"
SRC_URI="http://www.furryterror.org/~afong/pppoe/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE=""

S="${WORKDIR}/${P}/pppoed"

pkg_setup() {
	if kernel_is gt 2 4 ; then
		ewarn "This is a user space implementation of PPPoE!"
		ewarn
		ewarn "For 2.4 and 2.6 kernels you don't need this!"
		ewarn "The kernel already supports PPPoE, just enable it."
		epause 5
	fi
}
src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gcc-3.3.patch"
}

src_compile() {
	econf \
		--sysconfdir=/etc/ppp/pppoed || die "econf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README*

	cd ..
	docinto docs
	dodoc docs/*
	docinto contrib
	dodoc contribs/*
}
