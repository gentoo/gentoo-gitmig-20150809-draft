# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.7-r1.ebuild,v 1.2 2012/01/19 22:10:07 ago Exp $

EAPI=3
inherit eutils cmake-utils

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://marcansoft.com/blog/iphonelinux/usbmuxd/"
SRC_URI="http://marcansoft.com/uploads/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="app-pda/libplist
	virtual/libusb:1"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-receive_packet_overflow.patch #399409
}

DOCS="AUTHORS README README.devel"
