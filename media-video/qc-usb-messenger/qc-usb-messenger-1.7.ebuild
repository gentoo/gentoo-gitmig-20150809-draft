# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb-messenger/qc-usb-messenger-1.7.ebuild,v 1.2 2008/01/23 19:54:58 drac Exp $

inherit linux-mod

DESCRIPTION="Logitech USB Quickcam Express Messenger & Communicate Linux Driver Modules"
HOMEPAGE="http://home.mag.cx/messenger"
SRC_URI="http://home.mag.cx/messenger/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

CONFIG_CHECK="USB VIDEO_DEV VIDEO_V4L1_COMPAT"
MODULE_NAMES="quickcam(usb:)"
BUILD_TARGETS="all"

DEPEND="virtual/linux-sources
	!media-video/qc-usb"

pkg_setup() {
	ABI=${KERNEL_ABI}
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	convert_to_m Makefile
	epatch "${FILESDIR}"/${PN}-koutput.patch
}

src_install() {
	linux-mod_src_install

	dobin qcset
	dodoc README* APPLICATIONS CREDITS TODO FAQ _CHANGES_MESSENGER _README_MESSENGER

	insinto /usr/share/doc/${PF}
	doins *.sh
}
