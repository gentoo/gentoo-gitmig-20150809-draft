# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-firmware/bluez-firmware-1.0.ebuild,v 1.1 2004/09/26 18:48:22 liquidx Exp $

DESCRIPTION="Bluetooth Broadcom Firmware"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_install() {
	make DESTDIR=${D} install || die
}
