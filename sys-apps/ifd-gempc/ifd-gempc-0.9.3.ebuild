# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifd-gempc/ifd-gempc-0.9.3.ebuild,v 1.1 2004/12/30 22:41:55 dragonheart Exp $

DESCRIPTION="GemCore based PC/SC reader drivers for pcsc-lite"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC"
LICENSE="GPL-2 BSD"
KEYWORDS="~x86 ~ppc"
SLOT="0"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC/${P}.tar.gz"
IUSE=""
DEPEND=">=sys-devel/gcc-2.95.3-r5
	>=sys-apps/pcsc-lite-1.2.9_beta5"

RDEPEND=">=sys-apps/pcsc-lite-1.2.9_beta5"

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
