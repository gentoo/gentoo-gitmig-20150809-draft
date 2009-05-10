# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ifp-line/ifp-line-0.2.4.5.ebuild,v 1.5 2009/05/10 16:27:22 ssuominen Exp $

DESCRIPTION="iRiver iFP open-source driver"
HOMEPAGE="http://ifp-driver.sourceforge.net/"
SRC_URI="mirror://sourceforge/ifp-driver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc ppc x86"
IUSE=""

RDEPEND="dev-libs/libusb"
DEPEND="${RDEPEND}"

src_install() {
	dobin ifp || die "dobin failed"
	dodoc NEWS README TIPS
}

pkg_postinst() {
	ewarn "to use ifp-line as non-root user, please follow"
	ewarn "the TIPS file in /usr/share/doc/${PF}"
}
