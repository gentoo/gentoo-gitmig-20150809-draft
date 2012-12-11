# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.8-r1.ebuild,v 1.4 2012/12/11 14:07:15 axs Exp $

EAPI=4
inherit cmake-utils user udev

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

RDEPEND=">=app-pda/libplist-1.8-r1
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_configure() {
	# note: if package needs /usr mounted for rules to succeed, rules should always install to /usr
	if has_version virtual/udev; then
		sed -i -e "/rules/s:/lib/udev:$(udev_get_udevdir):" udev/CMakeLists.txt || die
	fi

	cmake-utils_src_configure
}

DOCS="AUTHORS README README.devel"
