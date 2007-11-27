# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/usb-pwc-re/usb-pwc-re-20061023.042702-r1.ebuild,v 1.8 2007/11/27 11:40:27 zzam Exp $

inherit linux-mod eutils

DESCRIPTION="Free Philips USB Webcam driver for Linux that supports VGA resolution, newer kernels and replaces the old pwcx module."
HOMEPAGE="http://www.saillard.org/pwc/"
MY_PV="${PV/./-}"
SRC_URI="http://www.saillard.org/linux/pwc/snapshots/pwc-v4l2-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"

IUSE=""
DEPEND="sys-kernel/linux-headers"
RDEPEND=""

# linux-mod variables
BUILD_TARGETS="all"
BUILD_PARAMS="KSRC=${KERNEL_DIR}"
MODULE_NAMES="pwc(media/video:)"
CONFIG_CHECK="USB VIDEO_V4L1_COMPAT !USB_PWC"
ERROR_USB="${P} requires Host-side USB support (CONFIG_USB)."
ERROR_USB_PWC="${P} requires the in-kernel version of the PWC driver to be disabled (CONFIG_USB_PWC)."
ERROR_VIDEO_V4L1_COMPAT="{$P} requires support for the Video For Linux API 1 compatibility layer (CONFIG_VIDEO_V4L1_COMPAT)."

S=${WORKDIR}/pwc-v4l2-${MY_PV}

pkg_setup() {
	if kernel_is 2 6; then
		if [ "${KV_PATCH}" -ge 18 ] ; then
			die "In kernel ${KV_FULL} this module is deprecated by the builtin driver."
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/config.h.patch"
}

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		eerror "${P} does not support building against kernel 2.4.x"
		die "${P} does not support building against kernel 2.4.x"
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "If you have problems loading the module, please check the \"dmesg\" output."
}
