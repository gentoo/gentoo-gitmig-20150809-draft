# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ifp-line/ifp-line-0.2.3.ebuild,v 1.1 2004/03/15 00:29:42 eradicator Exp $

DESCRIPTION="iRiver iFP open-source driver"
HOMEPAGE="http://ifp-driver.sourceforge.net/"
SRC_URI="mirror://sourceforge/ifp-driver/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86" # User-submitted contained: "~sparc ~amd64 ~ppc"

DEPEND="dev-libs/libusb"

src_compile() {
	emake || die "Make failed"
}

src_install() {
	dobin ifp
	dodoc COPYING NEWS README TIPS
}

pkg_postinst() {
	ewarn
	ewarn "to use ifp-line as non-root user, please follow"
	ewarn "the instructions in /usr/share/doc/${P}/TIPS.gz"
	ewarn
}
