# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/usb-robot/usb-robot-0.2.0.ebuild,v 1.10 2009/06/28 17:58:15 patrick Exp $

EAPI="2"

DESCRIPTION="USB Reverse engineering tools"
HOMEPAGE="http://usb-robot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/libusb:0
	sys-libs/readline"

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README ChangeLog
}
