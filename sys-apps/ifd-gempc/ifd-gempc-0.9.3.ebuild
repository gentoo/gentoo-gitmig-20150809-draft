# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifd-gempc/ifd-gempc-0.9.3.ebuild,v 1.2 2005/06/21 12:22:06 dragonheart Exp $

DESCRIPTION="GemCore based PC/SC reader drivers for pcsc-lite"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC"
LICENSE="GPL-2 BSD"
KEYWORDS="~ppc ~x86"
SLOT="0"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC/${P}.tar.gz"
IUSE=""
DEPEND=">=sys-apps/pcsc-lite-1.2.9_beta5
	>=dev-libs/libusb-0.1.10a"

src_compile() {
	emake || die
}

src_install () {
	emake DESTDIR=${D}/usr/lib install || die

	# Below makes this consistant with pcsc-slb-rf72-drv
	mv ${D}/usr/lib/pcsc/drivers ${D}/usr/lib/readers
	rmdir ${D}/usr/lib/pcsc
	dodoc README*
}
