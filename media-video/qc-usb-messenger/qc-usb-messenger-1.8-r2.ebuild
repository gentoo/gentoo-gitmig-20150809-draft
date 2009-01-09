# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb-messenger/qc-usb-messenger-1.8-r2.ebuild,v 1.2 2009/01/09 21:28:44 coldwind Exp $

inherit eutils linux-mod

DESCRIPTION="Logitech USB Quickcam Express Messenger & Communicate Linux Driver Modules"
HOMEPAGE="http://home.mag.cx/messenger"
SRC_URI="http://home.mag.cx/messenger/source/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

CONFIG_CHECK="USB VIDEO_DEV VIDEO_V4L1_COMPAT"
MODULE_NAMES="qcmessenger(usb:)"
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
	epatch "${FILESDIR}"/${P}-kcompat-2.6.26.patch
	epatch "${FILESDIR}"/${P}-kcompat-2.6.27.patch
	epatch "${FILESDIR}"/${P}-kcompat-2.6.28.patch
	epatch "${FILESDIR}"/${P}-ppc.patch
}

src_install() {
	linux-mod_src_install

	dobin qcset
	dodoc README* APPLICATIONS CREDITS TODO FAQ _CHANGES_MESSENGER _README_MESSENGER

	insinto /usr/share/doc/${PF}
	doins *.sh
}

pkg_postinst() {
	elog "QuickCam Messenger module is now called 'qcmessenger'."
}
