# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.0.1.ebuild,v 1.1 2006/04/22 21:01:29 vanquirius Exp $

inherit eutils

DL_NUM="1563"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${DL_NUM}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=">=sys-apps/pcsc-lite-1.2.9_beta9
	>=dev-libs/libusb-0.1.4"

src_install() {
	make install DESTDIR="${D}" || die "Cannot install"
	dodoc README AUTHORS
}
