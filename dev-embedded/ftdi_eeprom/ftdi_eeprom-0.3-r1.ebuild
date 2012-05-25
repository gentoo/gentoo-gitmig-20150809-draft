# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ftdi_eeprom/ftdi_eeprom-0.3-r1.ebuild,v 1.2 2012/05/25 08:10:16 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Utility to program external EEPROM for FTDI USB chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"
SRC_URI="http://www.intra2net.com/en/developer/libftdi/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-embedded/libftdi
	dev-libs/confuse"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-newer-chips.patch #376117
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README src/example.conf
}
