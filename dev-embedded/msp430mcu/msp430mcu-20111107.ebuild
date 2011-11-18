# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430mcu/msp430mcu-20111107.ebuild,v 1.1 2011/11/18 06:59:55 radhermit Exp $

EAPI="4"

DESCRIPTION="MCU-specific data for MSP430 microcontrollers"
HOMEPAGE="http://mspgcc.sourceforge.net"
SRC_URI="mirror://sourceforge/mspgcc/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	MSP430MCU_ROOT="${S}" ./scripts/install.sh "${D}/usr"
}
