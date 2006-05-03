# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.3.ebuild,v 1.7 2006/05/03 22:56:02 genstef Exp $

inherit linux-mod eutils multilib

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

CONFIG_CHECK="USB VIDEO_DEV"
MODULE_NAMES="quickcam(usb:)"
BUILD_TARGETS="all"

pkg_setup() {
	ABI=${KERNEL_ABI}
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Linux 2.6.16 compatibility, bug #127018
	epatch ${FILESDIR}/${P}-linux-2.6.16.patch
	convert_to_m ${S}/Makefile
	epatch ${FILESDIR}/qc-usb-gcc4.patch
}

src_install() {
	linux-mod_src_install

	dobin qcset
	dodoc README* APPLICATIONS COPYING CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}
