# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppoed/pppoed-0.49.ebuild,v 1.3 2005/08/14 10:16:17 hansmi Exp $

inherit linux-info eutils

DESCRIPTION="User space implementation of PPP over Ethernet"
HOMEPAGE="http://www.furryterror.org/~afong/pppoe/"
SRC_URI="http://www.furryterror.org/~afong/pppoe/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/${P}/pppoed"

pkg_setup() {
	if kernel_is gt 2 4 ; then
		einfo "This is a user space implementation of PPPoE!"
		einfo
		ewarn "For 2.4 and 2.6 kernels you don't need this!"
		ewarn "The kernel already supports PPPoE, just enable it."
		epause 5
	fi
}
src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc-3.3.patch
}

src_compile() {
	econf \
		--sysconfdir=/etc/ppp/pppoed || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING NEWS README*

	cd ..
	docinto docs
	dodoc docs/*
	docinto contrib
	dodoc contribs/*
}
