# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/isight-firmware-tools/isight-firmware-tools-1.2.ebuild,v 1.2 2008/08/03 19:39:47 eva Exp $

inherit eutils

DESCRIPTION="Extract, load or export firmware for the iSight webcams"
HOMEPAGE="http://bersace03.free.fr/ift/"
SRC_URI="http://launchpad.net/${PN}/main/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib
	dev-libs/libusb
	dev-libs/libgcrypt"
#	>=sys-apps/hal-0.5.9"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	sys-apps/texinfo"

src_compile() {
	# https://bugs.launchpad.net/isight-firmware-tools/+bug/243255
	econf --enable-udev --disable-hal || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "You need to extract your firmware prior to being able to loading it"
	elog "ift-extract --apple-driver /macos/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport"
	elog "If you do not have OSX you can get AppleUSBVideoSupport from"
	elog "http://www.mediafire.com/?81xtkqyttjt"
}
