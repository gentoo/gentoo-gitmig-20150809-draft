# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linux-uvc/linux-uvc-0.0.1_pre51.ebuild,v 1.1 2006/09/01 09:36:21 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Linux driver and user-space tools for USB Video Class devices."
HOMEPAGE="http://linux-uvc.berlios.de/"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.bz2"
#ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk/"
#ESVN_OPTIONS="-r ${PV/*_pre}"
#svn co http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk linux-uvc-0.0.1_pre
#rm -r linux-uvc-0.0.1_pre*/.svn


LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="isight"
DEPEND=">=dev-libs/libusb-0.1.12"

MODULE_NAMES="uvcvideo(usb/media)"
BUILD_TARGETS="uvcvideo"
CONFIG_CHECK="VIDEO_DEV"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERNEL_DIR=${KV_DIR}"
	if use isight; then
		MODULESD_UVCVIDEO_ENABLED="yes"
		MODULESD_UVCVIDEO_ADDITIONS=( "pre-install uvcvideo /sbin/isight-firmware-tool /lib/firmware/AppleUSBVideoSupport; sleep 2" )
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use isight && epatch ${FILESDIR}/41-001-isight.patch
}

src_compile() {
	use isight && emake extract

	linux-mod_src_compile
}

src_install() {
	into /
	use isight && newsbin extract isight-firmware-tool

	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	ewarn "This is SVN checkout build -- against revision: ${PV/*_pre}"
	ewarn "If something is broken, you should get involved, and report"
	ewarn "back to the mailing list linux-uvc-devel@lists.berlios.de"

	if use isight; then
		elog "Using iSight cameras, you *must* install the firmware to /lib/firmware, for e.g:"
		elog "  mkdir -p /lib/firmware"
		elog "  cp /\${OSX_MOUNT}/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport /lib/firmware"
		elog "Check /etc/modules.d/uvcvideo for more info."
	fi
}
