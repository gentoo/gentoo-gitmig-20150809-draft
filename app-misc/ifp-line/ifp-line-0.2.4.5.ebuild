# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ifp-line/ifp-line-0.2.4.5.ebuild,v 1.1 2004/11/25 10:46:08 hanno Exp $

DESCRIPTION="iRiver iFP open-source driver"
HOMEPAGE="http://ifp-driver.sourceforge.net/"
SRC_URI="mirror://sourceforge/ifp-driver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libusb"

src_compile() {
	emake || die "Make failed"
}

src_install() {
	dobin ifp || die
	dodoc NEWS README TIPS
}

pkg_postinst() {
	ewarn "to use ifp-line as non-root user, please follow"
	ewarn "the instructions in /usr/share/doc/${PF}/TIPS.gz"
}
