# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.4.ebuild,v 1.4 2010/07/31 11:00:50 pacho Exp $

EAPI="3"

inherit eutils cmake-utils

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://marcansoft.com/blog/iphonelinux/usbmuxd/"
SRC_URI="http://marcansoft.com/uploads/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_/-}

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}
