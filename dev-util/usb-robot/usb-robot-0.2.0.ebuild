# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/usb-robot/usb-robot-0.2.0.ebuild,v 1.8 2007/08/11 04:16:17 beandog Exp $

DESCRIPTION="USB Reverse engineering tools"
HOMEPAGE="http://usb-robot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-libs/libusb
	sys-libs/readline"

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README ChangeLog
}
