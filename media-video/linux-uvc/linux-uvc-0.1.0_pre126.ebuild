# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linux-uvc/linux-uvc-0.1.0_pre126.ebuild,v 1.1 2007/09/27 21:30:21 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Linux driver and user-space tools for USB Video Class devices."
HOMEPAGE="http://linux-uvc.berlios.de/
	http://people.freedesktop.org/~rbultje/"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.bz2"
#ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk/"
#ESVN_OPTIONS="-r ${PV/*_pre}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="isight"
DEPEND=""

MODULE_NAMES="uvcvideo(usb/media:)"
BUILD_TARGETS=" "
CONFIG_CHECK="VIDEO_DEV"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use isight && epatch patch/isight-base.patch
	use isight && epatch patch/isight-against-uvcvideo-r126.diff
}

src_install() {
	insinto /lib/firmware
	use isight && doins firmware/AppleUSBVideoSupport

	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	ewarn "If something is broken, you should get involved, and report"
	ewarn "back to the mailing list linux-uvc-devel@lists.berlios.de"
}
