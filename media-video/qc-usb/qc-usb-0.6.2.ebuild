# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.2.ebuild,v 1.5 2005/03/09 15:16:27 liquidx Exp $

inherit linux-mod eutils

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/linux-sources"

src_unpack() {
	cd ${S}
	unpack ${A}
	epatch ${FILESDIR}/${PV}-linux-2.6.11.patch
}

src_compile() {
	emake KERNEL_DIR=${KERNEL_DIR} all || die
}

src_install() {
	insinto /lib/modules/${KV}/drivers/usb
	doins quickcam.${KV_OBJ}
	dobin qcset
	dodoc README* APPLICATIONS COPYING CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}

