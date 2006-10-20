# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.4.ebuild,v 1.3 2006/10/20 19:07:01 genstef Exp $

inherit linux-mod eutils multilib

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

CONFIG_CHECK="USB VIDEO_DEV"
MODULE_NAMES="quickcam(usb:)"
BUILD_TARGETS="all"

pkg_setup() {
	ABI=${KERNEL_ABI}
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	convert_to_m ${S}/Makefile
	epatch ${FILESDIR}/${P}-koutput.patch
	epatch ${FILESDIR}/qc-usb-linux-2.6.18-1.patch
	epatch ${FILESDIR}/qc-usb-linux-2.6.18-2.patch
}

src_install() {
	linux-mod_src_install

	dobin qcset
	dodoc README* APPLICATIONS COPYING CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}
