# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qc-usb/qc-usb-0.6.6-r1.ebuild,v 1.2 2009/01/04 14:53:35 maekke Exp $

inherit linux-mod eutils multilib

DESCRIPTION="Logitech USB Quickcam Express Linux Driver Modules"
HOMEPAGE="http://qce-ga.sourceforge.net/"
SRC_URI="mirror://sourceforge/qce-ga/${P}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

CONFIG_CHECK="USB VIDEO_DEV VIDEO_V4L1_COMPAT"
MODULE_NAMES="quickcam(usb:)"
BUILD_TARGETS="all"

RDEPEND="!media-video/qc-usb-messenger"
DEPEND="${RDEPEND}"

pkg_setup() {
	ABI=${KERNEL_ABI}
	linux-mod_pkg_setup
	BUILD_PARAMS="LINUX_DIR=${KV_DIR} OUTPUT_DIR=${KV_OUT_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	convert_to_m "${S}"/Makefile
	epatch "${FILESDIR}/${P}-koutput.patch"

	# Do not strip symbols
	sed -i -e "s/-s qcset.c/qcset.c/" Makefile

	# Fix compilation with 2.6.24
	epatch "${FILESDIR}/${P}-kcompat-2.6.24.patch"

	if kernel_is ge 2 6 26; then
		# Fix compilation with 2.6.26, bug #232390
		epatch "${FILESDIR}/${P}-kcompat-2.6.26.patch"
	fi

	if kernel_is ge 2 6 27; then
		# Fix compilation with 2.6.27
		epatch "${FILESDIR}/${P}-kcompat-2.6.27.patch"
	fi
}

src_install() {
	linux-mod_src_install

	dobin qcset
	dodoc README* APPLICATIONS CREDITS TODO FAQ

	insinto /usr/share/doc/${PF}
	doins quickcam.sh debug.sh freeshm.sh
}
