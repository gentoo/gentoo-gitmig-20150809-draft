# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.0.ebuild,v 1.2 2004/07/24 21:51:52 mr_bones_ Exp $

inherit kernel-mod

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/linux-sources"

src_compile() {
	emake KERNEL_DIR=${KERNEL_DIR} all || die
}

src_install() {
	insinto /lib/modules/${KV}/drivers/usb
	if kernel-mod_is_2_6_kernel; then
		doins quickcam.ko
	else
		doins quickcam.o
	fi

	dobin /usr/bin/qcset
	dodoc README* APPLICATIONS COPYING CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}

pkg_postinst() {
	if kernel-mod_is_2_4_kernel; then
		/usr/sbin/update-modules
	fi

	einfo "The kernel module for quickcam.{o,ko} is installed for the"
	einfo "kernel linked by /usr/src/linux."
}
