# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linux-uvc/linux-uvc-0.1.0_pre157.ebuild,v 1.1 2007/12/19 11:35:30 genstef Exp $

inherit linux-mod

DESCRIPTION="Linux driver and user-space tools for USB Video Class devices."
HOMEPAGE="http://linux-uvc.berlios.de/"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.bz2"
#ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk/"
#ESVN_OPTIONS="-r ${PV/*_pre}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="isight"
DEPEND="isight? ( media-video/isight-firmware-tools )"

MODULE_NAMES="uvcvideo(usb/media:)"
BUILD_TARGETS=" "
CONFIG_CHECK="VIDEO_DEV"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
}

pkg_postinst() {
	linux-mod_pkg_postinst
	ewarn "If something is broken, you should get involved, and report"
	ewarn "back to the mailing list linux-uvc-devel@lists.berlios.de"
}
