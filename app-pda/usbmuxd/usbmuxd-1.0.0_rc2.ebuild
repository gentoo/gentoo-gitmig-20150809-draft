# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.0_rc2.ebuild,v 1.1 2009/12/07 00:47:08 chainsaw Exp $

EAPI="2"

inherit base cmake-utils

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://marcansoft.com/blog/iphonelinux/usbmuxd/"
SRC_URI="http://marcansoft.com/uploads/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-cmake.patch"
)

S=${WORKDIR}/${P/_/-}
