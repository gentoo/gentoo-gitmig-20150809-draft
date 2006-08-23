# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/usb-robot/usb-robot-0.2.0.ebuild,v 1.5 2006/08/23 04:32:09 vapier Exp $

DESCRIPTION="USB Reverse engineering tools"
HOMEPAGE="http://usb-robot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libusb
	sys-libs/readline"

src_install () {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README ChangeLog
}
