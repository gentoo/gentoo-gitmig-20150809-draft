# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/usb-robot/usb-robot-0.2.0.ebuild,v 1.3 2004/07/15 00:13:59 agriffis Exp $

IUSE="perl readline"

DESCRIPTION="USB Reverse engineering tools"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://usb-robot.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/libusb"

src_compile() {
	econf \
		--enable-smtp \
		`use_enable perl` \
		`use_enable readline` || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS NEWS README TODO COPYING ChangeLog
}
