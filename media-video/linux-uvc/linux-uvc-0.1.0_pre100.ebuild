# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linux-uvc/linux-uvc-0.1.0_pre100.ebuild,v 1.2 2007/07/12 02:40:43 mr_bones_ Exp $

inherit eutils linux-mod

DESCRIPTION="Linux driver and user-space tools for USB Video Class devices."
HOMEPAGE="http://linux-uvc.berlios.de/
	http://people.freedesktop.org/~rbultje/"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.gz"
#ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk/"
#ESVN_OPTIONS="-r ${PV/*_pre}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="isight"
DEPEND=""

MODULE_NAMES="uvcvideo(usb/media:src)"
BUILD_TARGETS=" "
CONFIG_CHECK="VIDEO_DEV"

S=${WORKDIR}/against-revision-100

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	use isight || patch -p0 -R < ${S}/patch/isight.patch
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
