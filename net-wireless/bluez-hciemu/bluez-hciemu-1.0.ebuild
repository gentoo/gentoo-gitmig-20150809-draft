# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-hciemu/bluez-hciemu-1.0.ebuild,v 1.2 2003/07/13 20:56:55 aliz Exp $

DESCRIPTION="bluetooth HCI emulator"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=net-wireless/bluez-kernel-2.3
		>=net-wireless/bluez-libs-2.2"

src_install() {
	einstall || die
}

