# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ifd-gempc/ifd-gempc-0.9.1.ebuild,v 1.1 2004/03/23 19:56:09 dragonheart Exp $

DESCRIPTION="GemCore based PC/SC reader drivers for pcsc-lite"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC/ifd-GemPC.html"
LICENSE="GPL-2 BSD"
KEYWORDS="~x86"
SLOT="0"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/ifd-GemPC/${P}.tar.gz"
IUSE=""
DEPEND=">=sys-devel/gcc-2.95.3-r5
	sys-apps/pcsc-lite"

RDEPEND="sys-apps/pcsc-lite"

src_unpack() {
	unpack ${A}
	cd ${S}
	local patch
	for patch in ${FILESDIR}/${P}*.diff; do
		epatch ${patch}
	done
}

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
