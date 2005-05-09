# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.3.ebuild,v 1.3 2005/05/09 00:06:56 herbs Exp $

inherit linux-mod eutils

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="virtual/linux-sources"

src_compile() {
	emake LINUX_DIR=${KERNEL_DIR} all || die
}

src_install() {
	insinto /lib/modules/${KV}/drivers/usb
	doins quickcam.${KV_OBJ}
	dobin qcset
	dodoc README* APPLICATIONS COPYING CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}

