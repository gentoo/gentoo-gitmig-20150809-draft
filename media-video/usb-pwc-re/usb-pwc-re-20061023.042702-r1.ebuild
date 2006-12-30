# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwc-re/usb-pwc-re-20061023.042702-r1.ebuild,v 1.1 2006/12/30 11:26:02 phosphan Exp $


inherit linux-mod

DESCRIPTION="Free Philips USB Webcam driver for Linux that supports VGA resolution, newer kernels and replaces the old pwcx module."
HOMEPAGE="http://www.saillard.org/pwc/"
MY_PV="${PV/./-}"
SRC_URI="http://www.saillard.org/linux/pwc/snapshots/pwc-v4l2-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""
DEPEND="sys-kernel/linux-headers"
RDEPEND=""

# linux-mod variables
BUILD_TARGETS="all"
MODULE_NAMES="pwc(media/video:)"
CONFIG_CHECK="USB !USB_PWC"
ERROR_USB="${P} requires Host-side USB support (CONFIG_USB)."
ERROR_USB_PWC="${P} requires the in-kernel version of the PWC driver to be disabled (CONFIG_USB_PWC)."

S=${WORKDIR}/pwc-v4l2-${MY_PV}

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "If you have problems loading the module, please check the \"dmesg\" output."
}
