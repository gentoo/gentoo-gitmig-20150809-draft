# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ftdi_eeprom/ftdi_eeprom-0.2.ebuild,v 1.2 2012/05/22 16:39:20 ssuominen Exp $

DESCRIPTION="Utility to program external EEPROM for FTDI USB chips"
HOMEPAGE="http://www.intra2net.com/opensource/ftdi/"
SRC_URI="http://www.intra2net.com/opensource/ftdi/TGZ/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/confuse
	virtual/libusb
	dev-embedded/libftdi"

src_install() {
	emake DESTDIR=${D} install || die
}
