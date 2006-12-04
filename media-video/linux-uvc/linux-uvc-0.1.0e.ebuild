# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/linux-uvc/linux-uvc-0.1.0e.ebuild,v 1.1 2006/12/04 18:47:56 genstef Exp $

inherit eutils linux-mod

MY_P="${P/.0/.0-}"

DESCRIPTION="Linux driver and user-space tools for USB Video Class devices."
HOMEPAGE="http://linux-uvc.berlios.de/
	http://people.freedesktop.org/~rbultje/"
SRC_URI="http://people.freedesktop.org/~rbultje/${MY_P}.tar.gz"
#ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/linux-uvc/linux-uvc/trunk/"
#ESVN_OPTIONS="-r ${PV/*_pre}"


LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="isight"
DEPEND=">=dev-libs/libusb-0.1.12"

MODULE_NAMES="uvcvideo(usb/media)"
BUILD_TARGETS="uvcvideo"
CONFIG_CHECK="VIDEO_DEV"
S=${WORKDIR}/${MY_P}

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
	EPATCH_OPTS="-g0 -E --no-backup-if-mismatch -R"
	use isight || epatch ${FILESDIR}/isight.patch
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
	ewarn "If something is broken, you should get involved, and report"
	ewarn "back to the mailing list linux-uvc-devel@lists.berlios.de"

	if use isight; then
		elog "Using iSight cameras, you *must* install the firmware to /lib/firmware, for e.g:"
		elog "  mkdir -p /lib/firmware"
		elog "  cp /\${OSX_MOUNT}/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport /lib/firmware"
		elog "Check /etc/modules.d/uvcvideo for more info."
	fi
}
